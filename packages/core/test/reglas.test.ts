import { describe, expect, it } from 'vitest';
import {
  comprobarCandidato,
  comprobarPrecios,
  decidirEnvio,
  diaMadrid,
  dominioDelLead,
  dominioRegistrable,
  enFranja,
  esperaEntreEnvios,
  euros,
  limiteDelDia,
  normalizarProvincia,
  puedeTrabajar,
  siguienteApertura,
  type Conocidos,
} from '../src';

describe('dominios normalizados', () => {
  it('quita www, subdominios, protocolo y mayúsculas', () => {
    expect(dominioRegistrable('https://WWW.Casa-Pepe.es/contacto')).toBe('casa-pepe.es');
    expect(dominioRegistrable('http://tienda.casa-pepe.es')).toBe('casa-pepe.es');
    expect(dominioRegistrable('casa-pepe.es')).toBe('casa-pepe.es');
    expect(dominioRegistrable('Info@Reservas.Casa-Pepe.ES')).toBe('casa-pepe.es');
  });
  it('respeta los sufijos públicos de dos niveles', () => {
    expect(dominioRegistrable('www.bodega.com.es')).toBe('bodega.com.es');
    expect(dominioRegistrable('https://shop.bodega.co.uk')).toBe('bodega.co.uk');
  });
  it('en hostings compartidos el dominio es el subdominio del negocio, nunca el del hosting', () => {
    expect(dominioRegistrable('http://lacasetadelforn.blogspot.com/')).toBe('lacasetadelforn.blogspot.com');
    expect(dominioRegistrable('https://www.ciefocal-es.webnode.es/contacto')).toBe('ciefocal-es.webnode.es');
    expect(dominioRegistrable('https://blog.masia.wordpress.com')).toBe('masia.wordpress.com');
    expect(dominioRegistrable('blogspot.com')).toBeNull();
  });
  it('en plataformas sin dominio propio no hay dominio', () => {
    expect(dominioRegistrable('https://sites.google.com/view/casarural')).toBeNull();
    expect(dominioRegistrable('https://www.facebook.com/barpepe')).toBeNull();
  });
  it('suprimir un blog de Blogspot no bloquea a otro', () => {
    const conocidos: Conocidos = {
      emails: new Set(),
      dominios: new Set(),
      suprimidosEmail: new Set(['lacasetadelforn@gmail.com']),
      suprimidosDominio: new Set([dominioRegistrable('http://lacasetadelforn.blogspot.com')!]),
    };
    expect(comprobarCandidato({ email: 'canvila@gmail.com', web: 'http://can-vila.blogspot.com' }, conocidos).ok).toBe(true);
  });
  it('con email gratuito, el dominio del lead es el de su web', () => {
    expect(dominioDelLead({ email: 'pepe@gmail.com', web: 'http://www.casapepe.com' })).toBe('casapepe.com');
    expect(dominioDelLead({ email: 'hola@casapepe.com', web: 'http://otra.es' })).toBe('casapepe.com');
  });
});

describe('duplicados y supresión', () => {
  const conocidos: Conocidos = {
    emails: new Set(['info@mesonvalderrey.com']),
    dominios: new Set(['mesonvalderrey.com', 'alcaravan.es']),
    suprimidosEmail: new Set(['isabel@trufasbertolin.com']),
    suprimidosDominio: new Set(['trufasbertolin.com']),
  };

  it('bloquea un email ya contactado aunque cambien las mayúsculas', () => {
    expect(comprobarCandidato({ email: ' INFO@MesonValderrey.com ' }, conocidos)).toEqual({ ok: false, motivo: 'duplicado_email' });
  });
  it('bloquea otro email del mismo dominio normalizado', () => {
    expect(comprobarCandidato({ email: 'reservas@mesonvalderrey.com' }, conocidos)).toEqual({ ok: false, motivo: 'duplicado_dominio' });
    expect(comprobarCandidato({ email: 'x@gmail.com', web: 'https://WWW.alcaravan.es/' }, conocidos)).toEqual({
      ok: false,
      motivo: 'duplicado_dominio',
    });
  });
  it('la supresión manda: email y dominio, incluidos subdominios', () => {
    expect(comprobarCandidato({ email: 'isabel@trufasbertolin.com' }, conocidos)).toEqual({ ok: false, motivo: 'suprimido_email' });
    expect(comprobarCandidato({ email: 'ventas@tienda.trufasbertolin.com' }, conocidos)).toEqual({
      ok: false,
      motivo: 'suprimido_dominio',
    });
    expect(comprobarCandidato({ email: 'trufas@gmail.com', web: 'http://www.trufasbertolin.com' }, conocidos)).toEqual({
      ok: false,
      motivo: 'suprimido_dominio',
    });
  });
  it('sin email no hay lead contactable', () => {
    expect(comprobarCandidato({ email: '', web: 'http://nuevo.es' }, conocidos)).toEqual({ ok: false, motivo: 'sin_email' });
  });
  it('deja pasar un negocio nuevo', () => {
    expect(comprobarCandidato({ email: 'Hola@Nuevo.es', web: 'nuevo.es' }, conocidos)).toEqual({
      ok: true,
      email: 'hola@nuevo.es',
      dominio: 'nuevo.es',
    });
  });
});

describe('territorio', () => {
  it('normaliza los nombres de provincia', () => {
    expect(normalizarProvincia('Baleares')).toBe('Illes Balears');
    expect(normalizarProvincia('vizcaya')).toBe('Bizkaia');
    expect(normalizarProvincia('ALAVA')).toBe('Álava');
    expect(normalizarProvincia('Castellon')).toBe('Castellón');
    expect(normalizarProvincia('Narnia')).toBeNull();
  });
  it('Guzmán rastrea sus provincias activas', () => {
    expect(puedeTrabajar('guzman', 'Valencia', 'rastreo')).toEqual({ ok: true });
  });
  it('Hunter no toca las provincias de Hugo', () => {
    expect(puedeTrabajar('guzman', 'Sevilla', 'rastreo')).toEqual({ ok: false, motivo: 'provincia_ajena' });
    expect(puedeTrabajar('guzman', 'A Coruña', 'contacto')).toEqual({ ok: false, motivo: 'provincia_ajena' });
    expect(puedeTrabajar('guzman', 'la coruña', 'contacto')).toEqual({ ok: false, motivo: 'provincia_ajena' });
  });
  it('las provincias ya trabajadas no se rastrean, pero sus leads se pueden seguir', () => {
    expect(puedeTrabajar('guzman', 'Murcia', 'rastreo')).toEqual({ ok: false, motivo: 'rastreo_apagado' });
    expect(puedeTrabajar('guzman', 'Murcia', 'contacto')).toEqual({ ok: true });
  });
  it('una provincia desconocida no se toca', () => {
    expect(puedeTrabajar('guzman', 'Lisboa', 'rastreo')).toEqual({ ok: false, motivo: 'provincia_desconocida' });
  });
});

describe('ventanas de envío y cambio de hora', () => {
  // 2026-10-22 es jueves (horario de verano, UTC+2); 2026-10-26 es lunes (invierno, UTC+1).
  it('jueves 22-oct-2026: las 9:00 de Madrid son las 07:00 UTC', () => {
    expect(enFranja('nuevo', new Date('2026-10-22T06:59:00Z'))).toBe(false);
    expect(enFranja('nuevo', new Date('2026-10-22T07:00:00Z'))).toBe(true);
    expect(enFranja('nuevo', new Date('2026-10-22T08:59:00Z'))).toBe(true);
    expect(enFranja('nuevo', new Date('2026-10-22T09:00:00Z'))).toBe(false);
  });
  it('lunes 26-oct-2026, tras el cambio del 25: las 9:00 de Madrid son las 08:00 UTC', () => {
    expect(enFranja('nuevo', new Date('2026-10-26T07:30:00Z'))).toBe(false); // 8:30 en Madrid
    expect(enFranja('nuevo', new Date('2026-10-26T08:00:00Z'))).toBe(true);
    expect(enFranja('nuevo', new Date('2026-10-26T09:59:00Z'))).toBe(true);
    expect(enFranja('nuevo', new Date('2026-10-26T10:00:00Z'))).toBe(false);
  });
  it('el domingo del cambio no se envía, y la siguiente apertura es el lunes a las 9:00 de invierno', () => {
    const domingo = new Date('2026-10-25T01:30:00Z'); // 2:30 → 3:00 pasa a 2:00
    expect(enFranja('nuevo', domingo)).toBe(false);
    expect(siguienteApertura('nuevo', domingo).toISOString()).toBe('2026-10-26T08:00:00.000Z');
  });
  it('un correo preparado el jueves por la tarde del 22-oct sale el lunes 26 a las 9:00 (con la hora nueva)', () => {
    expect(siguienteApertura('nuevo', new Date('2026-10-22T15:00:00Z')).toISOString()).toBe('2026-10-26T08:00:00.000Z');
  });
  it('también el cambio de primavera: lunes 29-mar-2027, las 9:00 son las 07:00 UTC', () => {
    expect(siguienteApertura('nuevo', new Date('2027-03-27T12:00:00Z')).toISOString()).toBe('2027-03-29T07:00:00.000Z');
  });
  it('el día natural se cuenta en Madrid, no en UTC', () => {
    expect(diaMadrid(new Date('2026-10-25T22:30:00Z'))).toBe('2026-10-25'); // 23:30 en Madrid
    expect(diaMadrid(new Date('2026-10-25T23:30:00Z'))).toBe('2026-10-26'); // 00:30 en Madrid
  });
  it('viernes: nuevos no, respuestas sí', () => {
    const viernes = new Date('2026-10-23T08:00:00Z'); // 10:00 en Madrid
    expect(enFranja('nuevo', viernes)).toBe(false);
    expect(enFranja('respuesta', viernes)).toBe(true);
  });
  it('seguimientos de 11:00 a 13:00', () => {
    expect(enFranja('seguimiento', new Date('2026-10-26T09:30:00Z'))).toBe(false); // 10:30
    expect(enFranja('seguimiento', new Date('2026-10-26T10:30:00Z'))).toBe(true); // 11:30
  });
});

describe('límites de envío', () => {
  const lunes10h = new Date('2026-10-26T09:00:00Z');
  it('máximo 50 al día por cuenta', () => {
    expect(decidirEnvio({ tipo: 'nuevo', ahora: lunes10h, enviadosHoy: 49, cuenta: {} })).toEqual({ enviar: true });
    const d = decidirEnvio({ tipo: 'nuevo', ahora: lunes10h, enviadosHoy: 50, cuenta: {} });
    expect(d.enviar).toBe(false);
    if (!d.enviar) {
      expect(d.motivo).toBe('limite_diario');
      expect(d.reintentarEn?.toISOString()).toBe('2026-10-27T08:00:00.000Z');
    }
  });
  it('el límite es configurable por cuenta', () => {
    expect(decidirEnvio({ tipo: 'nuevo', ahora: lunes10h, enviadosHoy: 20, cuenta: { limiteDiario: 20 } }).enviar).toBe(false);
  });
  it('fuera de la franja se espera a la siguiente apertura', () => {
    const d = decidirEnvio({ tipo: 'nuevo', ahora: new Date('2026-10-26T12:00:00Z'), enviadosHoy: 0, cuenta: {} });
    expect(d).toMatchObject({ enviar: false, motivo: 'fuera_de_franja' });
  });
  it('respeta la espera aleatoria de 2 a 6 minutos entre envíos', () => {
    expect(esperaEntreEnvios(0)).toBe(2 * 60_000);
    expect(esperaEntreEnvios(0.5)).toBe(4 * 60_000);
    expect(esperaEntreEnvios(0.999999)).toBeLessThanOrEqual(6 * 60_000);
    const noAntesDe = new Date(lunes10h.getTime() + 3 * 60_000);
    expect(decidirEnvio({ tipo: 'nuevo', ahora: lunes10h, enviadosHoy: 1, noAntesDe, cuenta: {} })).toMatchObject({
      enviar: false,
      motivo: 'espera_entre_envios',
      reintentarEn: noAntesDe,
    });
  });
  it('la pausa lo para todo', () => {
    expect(decidirEnvio({ tipo: 'respuesta', ahora: lunes10h, enviadosHoy: 0, cuenta: {}, pausa: true })).toMatchObject({
      enviar: false,
      motivo: 'pausa',
    });
  });
  it('rampa de calentamiento para cuentas nuevas', () => {
    const cuenta = { calentamientoDesde: '2026-10-26' };
    expect(limiteDelDia(cuenta, new Date('2026-10-26T09:00:00Z'))).toBe(10);
    expect(limiteDelDia(cuenta, new Date('2026-10-29T09:00:00Z'))).toBe(20);
    expect(limiteDelDia(cuenta, new Date('2026-11-02T09:00:00Z'))).toBe(30);
    expect(limiteDelDia(cuenta, new Date('2026-12-01T09:00:00Z'))).toBe(50);
    expect(limiteDelDia({ ...cuenta, limiteDiario: 25 }, new Date('2026-12-01T09:00:00Z'))).toBe(25);
    expect(decidirEnvio({ tipo: 'nuevo', ahora: lunes10h, enviadosHoy: 10, cuenta }).enviar).toBe(false);
  });
});

describe('precios', () => {
  it('acepta los precios del manual', () => {
    expect(comprobarPrecios('por 490 €, con todas las secciones')).toEqual([]);
    expect(comprobarPrecios('una web informativa por 290€')).toEqual([]);
  });
  it('nunca por debajo de 250 €', () => {
    expect(comprobarPrecios('te la dejo en 50 €')).toEqual([{ importe: 50, motivo: 'por_debajo_del_minimo' }]);
    expect(comprobarPrecios('por 199 euros')).toEqual([{ importe: 199, motivo: 'por_debajo_del_minimo' }]);
  });
  it('un precio no previsto lo decide Guzmán', () => {
    expect(comprobarPrecios('por 1.200 €')).toEqual([{ importe: 1200, motivo: 'precio_no_autorizado' }]);
  });
});

describe('formato español', () => {
  it('euros con separador de miles incluso con 4 cifras', () => {
    expect(euros(1234.56)).toBe('1.234,56 €');
    expect(euros(490, { enteros: true })).toBe('490 €');
    expect(euros(0.42)).toBe('0,42 €');
  });
});
