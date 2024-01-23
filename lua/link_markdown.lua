local M = {}
local telescope = require('telescope.builtin')
local action_state = require('telescope.actions.state')

function M.search_insert_link()
    local opts = {}
    opts.cwd = vim.g.linkmarkdown_base_path or vim.loop.cwd()

    telescope.find_files({
        prompt_title = "Insert Markdown Link",
        cwd = opts.cwd,
        attach_mappings = function(prompt_bufnr, map)
            local insert_link = function()
                local selection = action_state.get_selected_entry()
                local link_text = action_state.get_current_line()
                local relative_path = vim.fn.fnamemodify(selection.path, ":.")
                local markdown_link = string.format("[%s](%s)", link_text, relative_path)
                vim.fn.setreg('+', markdown_link)
                vim.cmd('stopinsert')
                require('telescope.actions').close(prompt_bufnr)
            end

            map('i', '<CR>', insert_link)
            map('n', '<CR>', insert_link)
            return true
        end
    })
end

return M

