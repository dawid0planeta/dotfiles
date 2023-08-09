-- Function for find selected
function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end
---@type MappingsTable
local M = {}

-- Your custom mappings
M.abc = {
    n = {
        ["<C-e>"] = {
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            "toggle harpoon menu",
        },
        ["<leader>a"] = {
            function ()
                require("harpoon.mark").add_file()
            end,
            "add file to harpoon",
        },
        ["<M-j>"] = {
            function ()
                require("harpoon.ui").nav_file(1)
            end,
            "harpoon nav file 1",
        },
        ["<M-k>"] = {
            function ()
                require("harpoon.ui").nav_file(2)
            end,
            "harpoon nav file 2",
        },
        ["<M-l>"] = {
            function ()
                require("harpoon.ui").nav_file(3)
            end,
            "harpoon nav file 3",
        },
        ["<M-f>"] = {
            function ()
                require("harpoon.ui").nav_file(4)
            end,
            "harpoon nav file 4",
        },
        ["<M-d>"] = {
            function ()
                require("harpoon.ui").nav_file(5)
            end,
            "harpoon nav file 5",
        },
        ["<M-s>"] = {
            function ()
                require("harpoon.ui").nav_file(6)
            end,
            "harpoon nav file 6",
        },
        ["<C-d>"] = {"<C-d>zz"},
        ["<C-u"] = {"<C-u>zz"},
        ["<leader>s"] = {[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]},
        ["<leader>u"] = {vim.cmd.UndotreeToggle},
        ["<C-j>"] = {"5j"},
        ["<C-k>"] = {"5k"},
        ["<leader>j"] = {"<c-w>j", "window down"},
        ["<leader>k"] = {"<c-w>k", "window up"},
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
        ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "git status" },
        ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "git branches" },
        ["<leader>fd"] = { "<cmd> Telescope find_files <CR>", "find files"},
        ["<leader>fe"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "fuzzy find buff"},
        ["<leader>fc"] = { "<cmd> Telescope commands <CR>", "find commands"},
        ["<leader>fp"] = { "<cmd> Telescope buffers <CR>", "find buffers"},
        ["<leader>fs"] = {
            function()
                require("auto-session.session-lens").search_session()
            end,
            "find session",
        },
        [";qq"] = {
            function()
                vim.api.nvim_command("wa")
                vim.api.nvim_command("SessionSave")
                vim.api.nvim_feedkeys(":qa", "n", true)
                local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
                vim.api.nvim_feedkeys(key, "n", false)
            end,
        },
        [";w"] = {
            function()
                vim.api.nvim_command("wa")
                vim.api.nvim_command("SessionSave")
                vim.api.nvim_command("tabdo NvimTreeOpen")
                local key = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
                vim.api.nvim_feedkeys(key, "n", false)
            end,
            "save all",
        },
        ["vv"] = { "viw", "select word"},
        ["P"] = { "<cmd> pu <CR> ==", "paste below"},
        ["<BS>"] = { "*N", "highlight current"},
        ["gr"] = { "<cmd> Trouble lsp_references <CR>", "list references"},
    },
    v = {
        ["J"] = {":m '>+1<CR>gv=gv"},
        ["K"] = {":m '<-2<CR>gv=gv"},
        ["<c-J>"] = {":m '>+5<CR>gv=gv"},
        ["<c-K>"] = {":m '<-6<CR>gv=gv"},
        ["<leader>fw"] = {function()
            local text = vim.getVisualSelection()
            require("telescope.builtin").live_grep({default_text = text})
            end,
            "live grep with visual selection",
        },
        ["<leader>fd"] = {function()
            local text = vim.getVisualSelection()
            require("telescope.builtin").find_files({default_text = text})
            end,
            "find files with visual selection",
        },
        ["<leader>fp"] = {function()
            local text = vim.getVisualSelection()
            require("telescope.builtin").buffers({default_text = text})
            end,
            "find buffer with visual selection",
        },
        ["<leader>fe"] = {function()
            local text = vim.getVisualSelection()
            require("telescope.builtin").current_buffer_fuzzy_find({default_text = text})
            end,
            "fuzzy find in buffer with visual selection",
        },
        ["y"] = { "m` y ``", "copy from place"},
    },
    i = {
        ["<Tab>"] = {
            function()
                -- if copilot.suggestions is visibile then accept else insert tab
                local suggestion = require("copilot.suggestion")
                if suggestion.is_visible() then
                    suggestion.accept()
                else
                    print(vim.api.nvim_replace_termcodes("<C-i>", true, false, true))
                    vim.api.nvim_feedkeys("    ", "i", false)
                end
            end,
            "accept copilot suggestion",
            opts = {noremap = true},
        },
        ["<C-s>"] = {"<cmd> write <CR>", "save file"}
    },
    t = {
        ["<Esc>"] = {"<C-\\><C-n>", "exit terminal mode"},
        ["<C-w>"] = {"<C-\\><C-n><C-w>", "exit terminal mode"},
        ["<C-h>"] = {"<C-\\><C-n><C-w>h", "exit terminal mode"},
        ["<C-j>"] = {"<C-\\><C-n><C-w>j", "exit terminal mode"},
        ["<C-k>"] = {"<C-\\><C-n><C-w>k", "exit terminal mode"},
        ["<C-l>"] = {"<C-\\><C-n><C-w>l", "exit terminal mode"},
    },
}

-- more keybinds!

return M
