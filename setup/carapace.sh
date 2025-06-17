zypper ar --gpgcheck-allow-unsigned -f https://yum.fury.io/rsteube/ carapace
zypper install -y carapace-bin

echo """export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)""" >> ~/.profile
