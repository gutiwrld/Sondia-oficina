import type { NextConfig } from 'next';

const config: NextConfig = {
  transpilePackages: ['@sondia/ui', '@sondia/core'],
  devIndicators: false,
  poweredByHeader: false,
};

export default config;
