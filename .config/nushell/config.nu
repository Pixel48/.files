# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
$env.config.show_banner = false

# use std/dirs

use std "path add"

path add /opt/homebrew/bin/
path add ~/.cargo/bin/
path add ~/.local/bin/
path add /usr/local/bin/
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.config.buffer_editor = "nvim"

$env.GL_HOST = 'https://gitlab.griddynamics.net'

source ~/.config/nushell/aliases.nu
source ~/.config/nushell/functions.nu
source ~/.config/nushell/tools.nu

# if (echo ~/.config/nushell/profile.nu | path exists) {
#   source ~/.config/nushell/profile.nu
# }
