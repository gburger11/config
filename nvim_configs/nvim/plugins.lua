-----------------------
-- auto-save.nvim
-----------------------
require("auto-save").setup {
    -- your config goes here
    -- or just leave it empty :)
    debounce_delay = 200,
    execution_message = {}
    }

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
        },
        haskell = {
            'adt'
        },
        rust = {
            'impl_item',

        },
        terraform = {
            'block',
            'object_elem',
            'attribute',
        },
        scala = {
            'object_definition',
        },
        vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
        },
        markdown = {
            'section',
        },
        elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
        },
        json = {
            'pair',
        },
        typescript = {
            'export_statement',
        },
        yaml = {
            'block_mapping_pair',
        },
        python = {
            'block_mapping_pair',
            'object_definition',
            'entity_declaration',
            'argument_list',
            'parenthesized_expression',
            'dictionary',
            'list',
            'set',
            'tuple',
            'elif',
            'else',
        },
        cpp = {
            'else',
            'else_if',
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp', 'python', 'vim', 'lua', 'markdown', 'toml' },
  callback = function() vim.treesitter.start() end,
})

vim.api.nvim_set_hl(0, "@function", { link = "GruvboxPurple" })

require('telescope').setup{
    defaults = {
        -- configure to use ripgrep   TODO : works ???
        vimgrep_arguments = {
            "rg",
            "--follow",        -- Follow symbolic links
            "--hidden",        -- Search for hidden files
            "--no-heading",    -- Don't group matches by each file
            "--with-filename", -- Print the file path with the matched lines
            "--line-number",   -- Show line numbers
            "--column",        -- Show column numbers
            "--smart-case",    -- Smart case search

            -- Exclude some patterns from search
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
        },
        mappings = {
            i = {
                ["<C-s>"] = "preview_scrolling_up",
                ["<C-t>"] = "preview_scrolling_down",
                ["<C-p>"] = {"<C-r>\"", type = "command"},
                ["<M-k>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
                ["<M-q>"] = require("telescope.actions").close,
            },
            n = {
                ["<M-k>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
                ["<M-q>"] = require("telescope.actions").close,
                ["s"] = "move_selection_previous",
                ["r"] = "move_selection_next",
                ["<S-s>"] = "preview_scrolling_up",
                ["<S-t>"] = "preview_scrolling_down",
                ["<C-s>"] = "preview_scrolling_up",
                ["<C-t>"] = "preview_scrolling_down",
                ["<C-h>"] = "file_split",
            },
        },
        prompt_prefix="🔍 ",
        cache_picker={
            num_pickers = 10,
        },
    },
    pickers = {
        find_files = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
            mappings = {
                i = {
                    ["<M-'>"] = {
                        "<Esc>02<right>v$hy:lua require('telescope.builtin').buffers { default_text = require('telescope.actions.state').get_current_line() }<CR>",
                        type="command"},
                },
                n = {
                    ["<M-'>"] = {
                        "02<right>v$hy:lua require('telescope.builtin').buffers { default_text = require('telescope.actions.state').get_current_line() }<cr>",
                        type="command"},
                },
            },
        },
        grep_string = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
        },
        buffers = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
                height = 30,
                -- preview_height = 15,
            },
            mappings = {
                i = {
                    ["<M-f>"] = {
                        "<Esc>02<right>v$hy:lua require('telescope.builtin').find_files { default_text = require('telescope.actions.state').get_current_line() }<CR>",
                        type="command"},
                },
                n = {
                    ["x"] = "delete_buffer",
                    ["<M-f>"] = {
                        "02<right>v$hy:lua require('telescope.builtin').find_files { default_text = require('telescope.actions.state').get_current_line() }<cr>",
                        type="command"},
                },
            },
        },
        live_grep = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
            mappings = {
                i = {
                    ["<M-h>"] = "to_fuzzy_refine",
                },
                n = {
                    ["<M-h>"] = "to_fuzzy_refine",
                },
            },
        },
        quickfix = {
            -- theme = "dropdown",
            layout_config = {
                width = 0.95,
            },
        },
    },
}

-- Make quickfix more beautiful

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

-- Adapt fzf's delimiter in nvim-bqf
require('bqf').setup({
    func_map = {
        pscrollup = "<S-s>",
        pscrolldown = "<S-t>",
        -- set to empty string to disable
        tab = '',
        tabb = '',
        tabc = '',
    },
    filter = {
        fzf = {
            action_for = {},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│', '--prompt', '> '}
        }
    }
})


-- which key
local wk = require("which-key")

wk.add({
  { "è", group = "Débug" },
  { "é", group = "Movements" },
  { "é.", "<Plug>(easymotion-repeat)", desc = "[easy] Repeat last move" },
  { "é/", "<Plug>(easymotion-sn)", desc = "[easy] search" },
  { "éN", "<Plug>(easymotion-vim-N)", desc = "[easy] previous search" },
  { "éd", desc = "Next git conflict position" },
  { "ée", "<Plug>(easymotion-bd-e)", desc = "[easy] Move to end word" },
  { "én", "<Plug>(easymotion-vim-n)", desc = "[easy] Next search" },
  { "éw", "<Plug>(easymotion-bd-w)", desc = "[easy] Move to start word" },
  { "éé", "<Plug>(easymotion-bd-f)", desc = "[easy] Move to char" },
})

local presets = require("which-key.plugins.presets")
presets.operators["c"] = nil


require('maximize').setup()

-- these are the defaults, customize as desired
require('ouroboros').setup({
    extension_preferences_table = {
          -- Higher numbers are a heavier weight and thus preferred.
          c = {h = 2, hpp = 1},
          cc = {h = 3, hpp = 2,  tpp = 1},
          h = {cc = 4, c = 3, cpp = 2, tpp = 1},
          cpp = {hpp = 2, h = 1},
          hpp = {cpp = 1, c = 2},
    },
})

require('gitsigns').setup()

vim.g.indentmini_key = '<F5>'
require("indentmini").setup({
    char = "¦",
})

require 'colorizer'.setup()
