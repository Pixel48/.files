vim.filetype.add {
  extension = {
    service = "systemd",
    container = "systemd",
    conf = "config",
  },
  filename = {
    [".stow-local-ignore"] = "gitignore",
  },
}
