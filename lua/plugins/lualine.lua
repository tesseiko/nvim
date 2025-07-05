if true then
  return {}
end
require("lualine").setup({
  options = {
    icons_enabled = true,
    -- theme = 'gruvbox_light',
    -- theme = 'gruvbox_dark',
    component_separators = "|",
    theme = "gruvbox-material",
    section_separators = "",
  },
})
