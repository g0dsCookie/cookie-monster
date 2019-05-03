export ZSH=/usr/share/zsh/oh-my-zsh
export ZSH_CACHE_DIR=$HOME/.cache/zsh/oh-my-zsh
export ZSH_CUSTOM=$HOME/.local/share/zsh/oh-my-zsh

# create missing directories
[[ ! -e "${ZSH_CACHE_DIR}" ]] && mkdir -p "${ZSH_CACHE_DIR}"
[[ ! -e "${ZSH_CUSTOM}" ]] && mkdir -p "${ZSH_CUSTOM}"

source $ZSH/oh-my-zsh.sh
