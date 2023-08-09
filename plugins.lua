local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

    -- Override plugin definition options
    -- install neovimremote
    -- pip3 install neovim-remote

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "custom.configs.null-ls"
                end,
            },
        },
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        -- after adding something using mason add it in null-ls.lua or lspconfig.lua
        "williamboman/mason.nvim",
        opts = overrides.mason
    },

    {
        "ziglang/zig.vim"
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = overrides.gitsigns,
    },
    {
        'rmagatti/auto-session',
        lazy = false,
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_enable_last_session = true,
                auto_session_enabled = true,
                auto_session_create_enabled = true,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                pre_save_cmds = {
                    function()
                        vim.cmd("tabdo NvimTreeClose")
                        vim.cmd("wa")
                    end
                },
                session_lens = {
                    load_on_setup = true,
                    -- theme_conf = { border = true },
                    -- previewer = false,
                },

            }
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
        lazy = false,
    },

    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.mapping["<Tab>"] = nil
            opts.mapping["<S-Tab>"] = nil
        end

    },

    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            opts.defaults = {
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        width = 0.9,
                        height = 0.9,
                        preview_width = 0.45,
                    },
                },
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                        ["<Tab>"] = require("telescope.actions").git_staging_toggle,
                        ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
                        ["<leader>j"]  = require("telescope.actions").preview_scrolling_down,
                        ["<leader>k"]  = require("telescope.actions").preview_scrolling_up,
                        ["<C-v"]  = require("telescope.actions").select_vertical,
                        ["<c-j>"] = require("telescope.actions").cycle_history_next,
                        ["<c-k>"] = require("telescope.actions").cycle_history_prev,
                    },
                    n = {
                        ["<esc>"] = require("telescope.actions").close,
                        ["<Tab>"] = require("telescope.actions").git_staging_toggle,
                        ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
                        ["<leader>j"]  = require("telescope.actions").preview_scrolling_down,
                        ["<leader>k"]  = require("telescope.actions").preview_scrolling_up,
                        ["<C-v"]  = require("telescope.actions").select_vertical,
                        ["<c-j>"] = require("telescope.actions").cycle_history_next,
                        ["<c-k>"] = require("telescope.actions").cycle_history_prev,
                    },
                }
            }
        end,
    },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup {
                mapping = {"jj"}, -- a table with mappings to use
                timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                -- keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
                -- example(recommended)
                keys = function()
                  return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                end,
            }
        end,
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },

    {
        "ThePrimeagen/harpoon",
    },

    {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                auto_preview = true,
                action_keys = {
                    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
                    preview = "p", -- preview the diagnostic location
                }
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept_word = false,
                        accept_line = false,
                        next = "<M-n>",
                        prev = "<M-p>",
                        dismiss = "<C-]>",
                    },
                },
                filetypes = {
                    yaml = false,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                },
                copilot_node_command = 'node', -- Node.js version must be > 16.x
                server_opts_overrides = {},
            })
        end,
    },
}

return plugins
