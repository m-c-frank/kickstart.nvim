local M = {}

function M.create_note()
    -- Unix timestamp in milliseconds
    local timestamp = tostring(os.time(os.date("!*t")) * 1000 + math.floor(vim.loop.hrtime() / 1000000) % 1000)
    local file_path = vim.g.note_storage_path or vim.loop.cwd()
    local full_path = string.format("%s/%s.md", file_path, timestamp)

    -- Create and open the new note file
    vim.cmd(string.format("edit %s", full_path))
end

return M

