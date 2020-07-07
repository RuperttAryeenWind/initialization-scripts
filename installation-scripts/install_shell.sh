# Nerd fonts are available via Homebrew Cask Fonts on macOS (OS X)
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

echo "ZPOWERLEVEL9K_MODE='nerdfont-complete'" >> ~/.zshrc

# To install this theme for use in Oh-My-Zsh, clone this repository into your OMZ custom/themes directory.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# You then need to select this theme in your ~/.zshrc:
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc

# Please note if you plan to set a POWERLEVEL9K_MODE to use a specific font, as described in this section of the Wiki, 
# you must set the MODE before OMZ is loaded (look for source $ZSH/oh-my-zsh.sh in your ~/.zshrc).