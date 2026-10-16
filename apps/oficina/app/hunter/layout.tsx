import { cookies } from 'next/headers';
import { BarraSuperior } from '@/componentes/barra-superior';
import { NavSala } from '@/componentes/nav-sala';
import { estadoHunter } from '@/lib/datos';
import { exigirSocio } from '@/lib/sesion';

export default async function SalaHunter({ children }: { children: React.ReactNode }) {
  const sesion = await exigirSocio();
  const estado = await estadoHunter();
  const tema = (await cookies()).get('tema')?.value === 'claro' ? 'claro' : 'oscuro';
  return (
    <>
      <BarraSuperior sesion={sesion} estado={estado.datos} tema={tema} departamento={{ etiqueta: 'Hunter · Dept. 01' }} />
      <NavSala mesa={estado.datos.mesa} />
      <main className="mx-auto max-w-[1440px] px-4 pb-20 pt-6 sm:px-6 sm:pt-8">{children}</main>
    </>
  );
}
