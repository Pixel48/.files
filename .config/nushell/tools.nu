alias tools = vim ~/.config/nushell/tools.nu

### carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshelllicense'
mkdir ~/.cache/carapace
carapace _carapace nushell | save -f ~/.cache/carapace/init.nu
source ~/.cache/carapace/init.nu

### zoxide
mkdir ~/.cache/zoxide
zoxide init --cmd cd nushell | save -f ~/.cache/zoxide/init.nu
source ~/.cache/zoxide/init.nu

### oh-my-posh
alias omp = oh-my-posh
mkdir ~/.cache/oh-my-posh/
oh-my-posh init -p nu -c ~/.config/oh-my-posh/themes/dev.yml | save -f ~/.cache/oh-my-posh/init.nu
$env.SET_POSHCONTEXT = {
	$env.JOBS = ( jobs | length );
}
source ~/.cache/oh-my-posh/init.nu
