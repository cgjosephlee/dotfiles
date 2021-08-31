----- compe -----
require('compe').setup {
    enabled = true,
    autocomplete = true,
    source = {
        path = true,
        buffer = true,
        calc = true,
        spell = true,
        tags = true,
        nvim_lsp = true,
        nvim_lua = true,
        treesitter = true,
    }
}

-- use tab to navigate completion menu
local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })",
                        { expr = true, silent = true, noremap = true })

----- lualine -----
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
        section_separators = {'', ''},
        component_separators = ''
    },
    sections = {
        lualine_a = {
            {
                mode_left_sep,
                left_padding = 0, right_padding = 0,
                color = 'lualine_mode_left_sep'
            },
            {
                'mode',
                left_padding = 0, right_padding = 0,
            }
        },
        lualine_b = {{
            'diagnostics',
            sources = {'nvim_lsp'},
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            right_padding = 0
        }},
        lualine_c = {{
            colored_filename,
            color = 'lualine_filename_color'
        }},
        lualine_x = {
            {'filetype'},
            {'encoding', left_padding = 0},
            {'fileformat', left_padding = 0, icons_enabled = false}
        },
        lualine_y = {
            {'progress'},
            {'location', left_padding = 0, right_padding = 0},
            {
                function() return '' end,
                left_padding = 0, right_padding = 0,
                color = 'lualine_c_normal_to_lualine_b_normal'
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
