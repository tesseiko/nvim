vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern="jack-main.service",
    command="!systemctl --user daemon-reload && systemctl --user restart jack-main.service",
})

