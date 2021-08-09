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
local patched_onedark = require'lualine.themes.onedark'
patched_onedark.insert = {a = {fg = '#282c34', bg = '#e5c07b', gui = 'bold'}}
patched_onedark.command = {a = {fg = '#282c34', bg = '#61afef', gui = 'bold'}}

require('lualine').setup {
    options = {
        theme = patched_onedark,
        section_separators = {'', ''},
        component_separators = ''
    },
    sections = {
        lualine_a = {{
            'mode',
            right_padding = 0, left_padding = 1,
        }},
        lualine_b = {{
            'diagnostics',
            sources = {'nvim_lsp'},
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            right_padding = 0
        }},
        lualine_c = {{
            'filename',
            path = 1,
            symbols = { modified = ' ', readonly = ' ' }
        }},
        lualine_x = {
            {'filetype'},
            {'encoding', left_padding = 0},
            {'fileformat', left_padding = 0, icons_enabled = false}
        },
        lualine_y = {
            {'progress', right_padding = 0},
            {'location', left_padding = 0},
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
