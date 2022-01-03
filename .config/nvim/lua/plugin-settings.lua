-- {{{ cmp
-- https://github.com/hrsh7th/nvim-cmp#setup
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip

local cmp = require('cmp')
local lspkind = require('lspkind')

-- for tab mapping
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
                feedkey('<Plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                feedkey('<Plug>(vsnip-jump-prev)', '')
            end
        end, { 'i', 's' })
    },
    sources = cmp.config.sources({  -- set gropu_index
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'path' },
        { name = 'buffer' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = ({
                nvim_lsp = '[LSP]',
                vsnip    = '[VSNIP]',
                buffer   = '[Buffer]',
                path     = '[PATH]',
                cmdline  = '[CMD]'
            })
        }),
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- }}}

-- {{{ lualine

local utils = require('lualine.utils.utils')
local patched_onedark = require('lualine.themes.onedark')
patched_onedark.insert = {a = {fg = '#282c34', bg = '#e5c07b', gui = 'bold'}}
patched_onedark.command = {a = {fg = '#282c34', bg = '#61afef', gui = 'bold'}}

local mode_left_sep = function()
    local function append_mode(highlight_group)
        local mode = require('lualine.utils.mode').get_mode()
        if mode == 'VISUAL' or mode == 'V-BLOCK' or mode == 'V-LINE' or mode ==
            'SELECT' or mode == 'S-LINE' or mode == 'S-BLOCK' then
            highlight_group = highlight_group .. '_visual'
        elseif mode == 'REPLACE' or mode == 'V-REPLACE' then
            highlight_group = highlight_group .. '_replace'
        elseif mode == 'INSERT' then
            highlight_group = highlight_group .. '_insert'
        elseif mode == 'COMMAND' or mode == 'EX' or mode == 'MORE' or mode ==
            'CONFIRM' then
            highlight_group = highlight_group .. '_command'
        elseif mode == 'TERMINAL' then
            highlight_group = highlight_group .. '_terminal'
        else
            highlight_group = highlight_group .. '_normal'
        end
        return highlight_group
    end
    local colors = {
        fg = utils.extract_highlight_colors(append_mode('lualine_a'), 'bg'),
        bg = utils.extract_highlight_colors('lualine_c_normal', 'bg')
    }
    vim.cmd('hi! lualine_mode_left_sep guifg=' .. colors.fg .. ' guibg=' .. colors.bg)
    return ''
end

local colored_filename = function()
    local symbols = {modified = ' ', readonly = ' '}
    local colors = {
        -- steal LSP settings
        saved = utils.extract_highlight_colors('LspDiagnosticsDefaultHint', 'fg'),
        modified = utils.extract_highlight_colors('LspDiagnosticsDefaultWarning', 'fg'),
        readonly = utils.extract_highlight_colors('LspDiagnosticsDefaultError', 'fg'),
        bg = utils.extract_highlight_colors('lualine_c_normal', 'bg')
    }
    local data = vim.fn.expand('%:~:.')  -- relative path
    local key
    if data == '' then data = '[No Name]' end
    if vim.bo.modified then
        data = data .. symbols.modified
        key = 'modified'
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        data = data .. symbols.readonly
        key = 'readonly'
    else
        key = 'saved'
    end
    vim.cmd('hi! lualine_filename_color guifg=' .. colors[key] .. ' guibg=' .. colors.bg)
    return data
end

require('lualine').setup {
    options = {
        theme = patched_onedark,
        section_separators = {left = '', right = ''},
        component_separators = ''
    },
    sections = {
        lualine_a = {
            {
                mode_left_sep,
                padding = {left = 0, right = 0},
                color = 'lualine_mode_left_sep'
            },
            {
                'mode',
                padding = {left = 0, right = 0},
            }
        },
        lualine_b = {{
            'diagnostics',
            sources = {'nvim_lsp'},
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            padding = {left = 1, right = 0},
        }},
        lualine_c = {{
            colored_filename,
            color = 'lualine_filename_color'
        }},
        lualine_x = {
            {'filetype'},
            {'encoding', padding = {left = 0, right = 1}},
            {'fileformat', padding = {left = 0, right = 1}, icons_enabled = false}
        },
        lualine_y = {
            {'progress', padding = {left = 0, right = 1}},
            {'location', padding = {left = 0, right = 0}},
            {
                function() return '' end,
                padding = {left = 0, right = 0},
                color = 'lualine_transitional_lualine_b_normal_to_lualine_c_normal'
            }
        },
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', symbols = { modified = ' ', readonly = ' ' }}},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}

-- }}}
