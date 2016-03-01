##########################################################
################ [Setup the basics] ######################
##########################################################

# Install homebrew
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##########################################################
################ [Install and configure git] #############
##########################################################

brew install git
git config --global credential.helper osxkeychain
git config --global core.excludesfile '~/.gitignore'

##########################################################
################ [Setup node and nvm] ####################
##########################################################

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install stable
nvm use stable

npm install -g grunt-cli modulus
curl https://install.meteor.com/ | sh

##########################################################
################ [Install and setup ruby] ################
##########################################################

\curl -L https://get.rvm.io | bash -s stable --ruby

##########################################################
################ [Install apps and tools] ################
##########################################################

# Setup iTerm2
brew cask install iterm2

# Setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install other apps
brew cask install firefox google-chrome sizeup dropbox skype spotify 1password mou sourcetree slack

# After install sublime
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl



