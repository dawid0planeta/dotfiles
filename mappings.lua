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
            end
        },
        ["<M-j>"] = {
            function ()
                require("harpoon.ui").nav_file(1)
            end
        },
        ["<M-k>"] = {
            function ()
                require("harpoon.ui").nav_file(2)
            end
        },
        ["<M-l>"] = {
            function ()
                require("harpoon.ui").nav_file(3)
            end
        },
        ["<M-f>"] = {
            function ()
                require("harpoon.ui").nav_file(4)
            end
        },
        ["<M-d>"] = {
            function ()
                require("harpoon.ui").nav_file(5)
            end
        },
        ["<M-s>"] = {
            function ()
                require("harpoon.ui").nav_file(6)
            end
        },
    },
}



-- more keybinds!

return M
