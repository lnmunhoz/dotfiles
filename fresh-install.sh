# Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Store git credentials
git config --global credential.helper osxkeychain
git config --global core.excludesfile '~/.gitignore'

# Nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

# Apps
brew cask install iterm2
brew cask install slate
brew cask install karabiner-elements
brew cask install google-chrome
brew cask install dropbox
brew cask install 1password6
brew cask install authy
brew cask install pgadmin4
brew cask install robo3t
brew cask install visual-studio-code
brew cask install visual-studio-code


