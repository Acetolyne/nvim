local options = {
    autoindent = true,
    smartindent = true,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    showtabline = 0,
    wrap = false,
    number = true,
    relativenumber = true,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    scrolloff = 8,
}

for option, value in pairs(options) do
    vim.opt[option] = value
end
