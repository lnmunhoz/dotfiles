export ZSH="/Users/lnmunhoz/.oh-my-zsh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ZSH_THEME="awesomepanda"
plugins=(
   git
   z
   zsh-autosuggestions
   zsh-completions
   zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
