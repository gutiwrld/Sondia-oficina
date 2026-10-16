import type { Metadata, Viewport } from 'next';
import { cookies } from 'next/headers';
import { GeistMono } from 'geist/font/mono';
import { GeistSans } from 'geist/font/sans';
import '@fontsource/instrument-serif/400.css';
import '@fontsource-variable/sora/wght.css';
import './globals.css';

export const metadata: Metadata = {
  title: { default: 'SONDIA · Oficina', template: '%s · SONDIA' },
  description: 'La oficina de agentes de SONDIA.',
  robots: { index: false, follow: false },
};

export const viewport: Viewport = {
  width: 'device-width',
  initialScale: 1,
  themeColor: [
    { media: '(prefers-color-scheme: dark)', color: '#0d0d12' },
    { media: '(prefers-color-scheme: light)', color: '#fafaf7' },
  ],
};

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  // Oscuro por defecto (es el tema principal); el socio puede elegir claro y se guarda en una cookie.
  const tema = (await cookies()).get('tema')?.value === 'claro' ? 'light' : 'dark';
  return (
    <html lang="es-ES" data-theme={tema} className={`${GeistSans.variable} ${GeistMono.variable}`}>
      <body>{children}</body>
    </html>
  );
}
