local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, 
{ desc = "Add current file to harpoon" })


-- set up keymaps for accessing harpoon files by number. Number 0 is number 10
for idx = 1, 9 do
    local lhs = ("<leader>%d"):format(idx)
    vim.keymap.set("n", lhs, function()
        harpoon:list():select(idx)
    end, { desc = ("Harpoon: select slot %d"):format(idx) })
end

vim.keymap.set("n", "<leader>0", function()
    harpoon:list():select(10)
end, { desc = "Harpoon: select slot 10" })


-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    local finder = function()
        local results = {}
        for i, item in ipairs(harpoon_files.items) do
            table.insert(results, { idx = i, path = item.value })
        end

        return require("telescope.finders").new_table({
            results = results,
            entry_maker = function(entry)
                return {
                    value = entry.path,
                    ordinal = entry.path,
                    display = ("%d: %s"):format(entry.idx, entry.path),
                }
            end,
        })
    end

    require("telescope.pickers").new({}, {
        prompt_title = "search harpoon files",
        finder = finder(),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<C-d>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()

                if selected_entry then
                    table.remove(harpoon_files.items, selected_entry.index)
                end

                local current_picker = state.get_current_picker(prompt_bufnr)
                current_picker:refresh(finder())
            end, { desc = "Delete selected harpoon file" })
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
{ desc = "Open harpoon window" })
