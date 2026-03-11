vim.filetype.add {
  extension = {
    service = "systemd",
    container = "systemd",
    conf = "config",
  },
  filename = {
    ["config"] = "conf",
    [".stow-local-ignore"] = "gitignore",
  },
}
