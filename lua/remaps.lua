local opts = { noremap=true, silent=true }

vim.keymap.set('n', 'Y', 'y$'   , opts)
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', 'J', 'm`J``', opts)

vim.keymap.set('v', '<leader>i', '<C-a>'  ,opts)
vim.keymap.set('v', 'g<leader>i', 'g<C-a>',opts)
vim.keymap.set('n', '<leader>i', '<C-a>'  ,opts)

-- undo breakpoints
vim.keymap.set('i', ',', ',<C-g>u', opts)
vim.keymap.set('i', '.', '.<C-g>u', opts)
vim.keymap.set('i', ';', ';<C-g>u', opts)

-- moving
vim.keymap.set('n', '<leader>k', ':m .-2<cr>==', opts)
vim.keymap.set('n', '<leader>j', ':m .+1<cr>==', opts)
vim.keymap.set('v', 'K', ':m \'<-2<cr>gv=gv', opts)
vim.keymap.set('v', 'J', ':m \'>+1<cr>gv=gv', opts)

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.cpp", "*.c", "*.h"},
    callback = function(ev)
        vim.keymap.set('i', ';', '<esc>A;', opts)
    end
})
vim.keymap.set('i', '<C-l>', '<right>', opts)
vim.keymap.set('i', '<C-j>', '<down>', opts)
vim.keymap.set('i', '<C-k>', '<up>', opts)
vim.keymap.set('i', '<C-h>', '<left>', opts)
vim.keymap.set('i', '<C-M-e>', '€', opts)

vim.keymap.set('n', '<leader>y', '"py', opts)
vim.keymap.set('n', '<leader>p', '"pp', opts)
vim.keymap.set('n', '<leader>P', '"pP', opts)
vim.keymap.set('n', '<leader>d', '"_d', opts)

-- file navigation
vim.keymap.set('n', '<leader>?', ':tabnew ~/vimwiki/src/vim.md<cr>', opts)
vim.keymap.set('n', '<leader>rc', ':tabnew ~/.config/nvim/init.lua<cr>', opts)
vim.keymap.set('n', '<C-n>', ':bnext<cr>', opts)
vim.keymap.set('n', '<C-p>', ':bprev<cr>', opts)
vim.keymap.set('n', '<C-q>', ':b#<bar>:bd! #<bar>:bnext<bar>:bprev<bar>:<cr>', opts)

-- etc
vim.keymap.set('n', '<leader>M', '/<@><cr>', opts)
vim.keymap.set('n', '<leader><tab>', '/<@><cr>3cl', opts)
vim.keymap.set('n', '<leader><C-h>', ':tabprev<cr>', opts)
vim.keymap.set('n', '<leader><C-l>', ':tabnext<cr>', opts)
vim.keymap.set('n', '-', '<C-W><', opts)
vim.keymap.set('n', '+', '<C-W>>', opts)
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', opts)
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-k>', ':cprev<cr> ', opts)
vim.keymap.set('n', '<C-j>', ':cnext<cr>', opts)
vim.keymap.set('n', '<C-s>', ':w<cr>', opts)
vim.keymap.set('i', '<C-s>', '<esc>:w<cr>', opts)

vim.keymap.set('n', '<leader>lq', ':LspStop<cr>', opts)

-- surround current line with empty lines and reverse
vim.keymap.set('n', '<leader>s', 'O<esc>jo<esc>k', opts)
vim.keymap.set('n', '<leader>S', 'kddjddk', opts)


if vim.api.nvim_win_get_option(0, "diff") then
    vim.keymap.set('n', '<leader>dp', ':diffput<cr>', opts)
    vim.keymap.set('n', '<leader>dg', ':diffget<cr>', opts)
    vim.keymap.set('n', '<leader>dh', ':diffget 1<cr>', opts)
    vim.keymap.set('n', '<leader>dl', ':diffget 3<cr>', opts)
end

vim.keymap.set({'n', 'v'}, 'α', 'a')
vim.keymap.set({'n', 'v'}, 'ς', 'w')
vim.keymap.set({'n', 'v'}, 'ε', 'e')
vim.keymap.set({'n', 'v'}, 'ρ', 'r')
vim.keymap.set({'n', 'v'}, 'τ', 't')
vim.keymap.set({'n', 'v'}, 'υ', 'y')
vim.keymap.set({'n', 'v'}, 'θ', 'u')
vim.keymap.set({'n', 'v'}, 'ι', 'i')
vim.keymap.set({'n', 'v'}, 'ο', 'o')
vim.keymap.set({'n', 'v'}, 'π', 'p')
vim.keymap.set({'n', 'v'}, 'σ', 's')
vim.keymap.set({'n', 'v'}, 'δ', 'd')
vim.keymap.set({'n', 'v'}, 'φ', 'f')
vim.keymap.set({'n', 'v'}, 'γ', 'g')
vim.keymap.set({'n', 'v'}, 'η', 'h')
vim.keymap.set({'n', 'v'}, 'ξ', 'j')
vim.keymap.set({'n', 'v'}, 'κ', 'k')
vim.keymap.set({'n', 'v'}, 'λ', 'l')
vim.keymap.set({'n', 'v'}, 'ζ', 'z')
vim.keymap.set({'n', 'v'}, 'χ', 'x')
vim.keymap.set({'n', 'v'}, 'ψ', 'c')
vim.keymap.set({'n', 'v'}, 'ω', 'v')
vim.keymap.set({'n', 'v'}, 'β', 'b')
vim.keymap.set({'n', 'v'}, 'ψ', 'c')
vim.keymap.set({'n', 'v'}, 'μ', 'm')
vim.keymap.set({'n', 'v'}, 'ν', 'n')

vim.keymap.set({'n', 'v'}, 'Α', 'A')
vim.keymap.set({'n', 'v'}, 'Σ', 'W')
vim.keymap.set({'n', 'v'}, 'Ε', 'E')
vim.keymap.set({'n', 'v'}, 'Ρ', 'R')
vim.keymap.set({'n', 'v'}, 'Τ', 'T')
vim.keymap.set({'n', 'v'}, 'Υ', 'Y')
vim.keymap.set({'n', 'v'}, 'Θ', 'U')
vim.keymap.set({'n', 'v'}, 'Ι', 'I')
vim.keymap.set({'n', 'v'}, 'Ο', 'O')
vim.keymap.set({'n', 'v'}, 'Π', 'P')
vim.keymap.set({'n', 'v'}, 'Σ', 'S')
vim.keymap.set({'n', 'v'}, 'Δ', 'D')
vim.keymap.set({'n', 'v'}, 'Φ', 'F')
vim.keymap.set({'n', 'v'}, 'Γ', 'G')
vim.keymap.set({'n', 'v'}, 'Η', 'H')
vim.keymap.set({'n', 'v'}, 'Ξ', 'J')
vim.keymap.set({'n', 'v'}, 'Κ', 'K')
vim.keymap.set({'n', 'v'}, 'Λ', 'L')
vim.keymap.set({'n', 'v'}, 'Ζ', 'Z')
vim.keymap.set({'n', 'v'}, 'Χ', 'X')
vim.keymap.set({'n', 'v'}, 'Ψ', 'C')
vim.keymap.set({'n', 'v'}, 'Ω', 'V')
vim.keymap.set({'n', 'v'}, 'Β', 'B')
vim.keymap.set({'n', 'v'}, 'Ψ', 'C')
vim.keymap.set({'n', 'v'}, 'Μ', 'M')
vim.keymap.set({'n', 'v'}, 'Ν', 'Ν')

vim.keymap.set({'n', 'v'}, 'γ;ιπ', 'gqip')
vim.keymap.set({'n', 'v'}, 'ψς', 'cw')
vim.keymap.set({'n', 'v'}, 'ψις', 'ciw')
vim.keymap.set({'n', 'v'}, 'δς', 'dw')
