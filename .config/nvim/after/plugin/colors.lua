-- let color = vim.cmd('source ~/.cache/wal/colors-wal.vim')

function Colorize(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })
end

Colorize()
