return {
  'nvim-tree/nvim-web-devicons',
  opts = {
    strict = true,
    override_by_filename = {
      ['vite.config.ts'] = {
        icon = '󱐋',
        color = '#FFAB00',
        name = 'Vite',
      },
      ['vite.config.js'] = {
        icon = '󱐋',
        color = '#FFAB00',
        name = 'Vite',
      },
      ['vite.config.mts'] = {
        icon = '󱐋',
        color = '#FFAB00',
        name = 'Vite',
      },
      ['vitest.config.ts'] = {
        icon = '󱐋',
        color = '#6E9F18',
        name = 'Vitest',
      },
      ['vitest.config.js'] = {
        icon = '󱐋',
        color = '#6E9F18',
        name = 'Vitest',
      },
      ['vitest.config.mts'] = {
        icon = '󱐋',
        color = '#6E9F18',
        name = 'Vitest',
      },
    },
    override_by_extension = {
      ['astro'] = {
        icon = '',
        color = '#EF8547',
        name = 'Astro',
      },
    },
  },
}
