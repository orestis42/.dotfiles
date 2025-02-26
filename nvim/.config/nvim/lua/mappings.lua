require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Function to copy current buffer diagnostics to the clipboard
local function copy_diagnostics_to_clipboard()
  local diags = vim.diagnostic.get(0) -- get diagnostics for current buffer
  if vim.tbl_isempty(diags) then
    print("No diagnostics found!")
    return
  end
  local output = {}
  for _, diag in ipairs(diags) do
    local severity = vim.diagnostic.severity[diag.severity] or "Unknown"
    table.insert(output, string.format("[%s] %s (line %d)", severity, diag.message, diag.lnum + 1))
  end
  local text = table.concat(output, "\n")
  vim.fn.setreg('+', text)  -- copy to system clipboard using the '+' register
  print("Diagnostics copied to clipboard!")
end

-- Map the function to a keybinding (<leader>cd)
map("n", "<leader>cd", copy_diagnostics_to_clipboard, { desc = "Copy diagnostics to clipboard" })

