// Capturas de la oficina a 1440 y 390 px, en oscuro y en claro.
// Uso: con la oficina corriendo (pnpm dev), `pnpm capturas [fase]`. Guarda en capturas/<fase>/.
import { mkdirSync } from 'node:fs';
import { join } from 'node:path';
import { chromium } from 'playwright-core';

const BASE = process.env.OFICINA_URL ?? 'http://localhost:3000';
const FASE = process.argv[2] ?? 'fase-1';
const SALIDA = join(import.meta.dirname, '../../../capturas', FASE);
const CHROMIUM = process.env.CHROMIUM_PATH ?? '/opt/pw-browsers/chromium-1194/chrome-linux/chrome';

const PANTALLAS = [
  ['vestibulo', '/'],
  ['hoy', '/hunter'],
  ['mesa', '/hunter/mesa'],
  ['radar', '/hunter/radar'],
  ['bandeja', '/hunter/bandeja'],
  ['agenda', '/hunter/agenda'],
  ['rastro', '/hunter/rastro'],
  ['ajustes', '/hunter/ajustes'],
  ['entrar', '/entrar'],
];
const ANCHOS = [1440, 390];
const TEMAS = ['oscuro', 'claro'];

mkdirSync(SALIDA, { recursive: true });
const navegador = await chromium.launch({ executablePath: CHROMIUM });
for (const tema of TEMAS) {
  for (const ancho of ANCHOS) {
    const ctx = await navegador.newContext({
      viewport: { width: ancho, height: ancho === 390 ? 844 : 900 },
      deviceScaleFactor: ancho === 390 ? 2 : 1,
      locale: 'es-ES',
      timezoneId: 'Europe/Madrid',
      reducedMotion: 'reduce',
    });
    await ctx.addCookies([{ name: 'tema', value: tema, url: BASE }]);
    const pagina = await ctx.newPage();
    for (const [nombre, ruta] of PANTALLAS) {
      await pagina.goto(BASE + ruta, { waitUntil: 'networkidle' });
      await pagina.evaluate(() => document.fonts.ready);
      // La página nunca debe tener scroll horizontal.
      const desborde = await pagina.evaluate(() => document.documentElement.scrollWidth - window.innerWidth);
      if (desborde > 0) console.warn(`⚠ ${nombre} ${ancho}px ${tema}: desborda ${desborde}px en horizontal`);
      await pagina.screenshot({ path: join(SALIDA, `${nombre}-${ancho}-${tema}.png`), fullPage: true });
    }
    await ctx.close();
  }
}
await navegador.close();
console.log(`Capturas en ${SALIDA}`);
