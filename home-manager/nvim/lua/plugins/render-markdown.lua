return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {
        code = {
            width = 'block',
            min_width = '120',
            left_pad = 1,
            left_margin = 1,
            language_border = ' ',
            language_left = ' ',
            language_right = '',
        }
    },
}
