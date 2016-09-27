echo "Installing XCode"
xcode-select --install

echo "Installing Homebrew"
fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

# shellcheck disable=SC2016
append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

case "$SHELL" in
  */zsh) : ;;
  *)
    fancy_echo "Changing your shell to zsh ..."
      chsh -s "$(which zsh)"
    ;;
esac

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
    rbenv rehash
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    append_to_zshrc '# recommended by brew doctor'

    # shellcheck disable=SC2016
    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

echo "Setting Taps in Homebrew"
brew tap homebrew/science
brew tap homebrew/python
brew tap homebrew/services
brew tap thoughtbot/formulae

brew doctor
brew outdated
brew update 
brew upgrade

echo "Installing Essentials"
brew install ctags wget
brew install openssl
brew install tmux
brew install maven cmake gcc freetype
brew install vim zsh
brew install libtiff libjpeg 
brew install webp 
brew install py2cairo cairo
brew install little-cms2
brew install graphviz --with-librsvg --with-x11

# GitHub
brew install git
brew install hub

# Testing
brew install qt pyqt

# Programming languages
brew install libyaml
brew install rbenv
brew install ruby-build

fancy_echo "Configuring Ruby ..."
find_latest_ruby() {
  rbenv install -l | grep -v - | tail -1 | sed -e 's/^ *//'
}

ruby_version="$(find_latest_ruby)"
# shellcheck disable=SC2016
append_to_zshrc 'eval "$(rbenv init - --no-rehash)"' 1
eval "$(rbenv init -)"

if ! rbenv versions | grep -Fq "$ruby_version"; then
  RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/opt/openssl rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"
gem update --system
gem_install_or_update 'bundler'
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

if [ -f "$HOME/.laptop.local" ]; then
  fancy_echo "Running your customizations from ~/.laptop.local ..."
  # shellcheck disable=SC1090
  . "$HOME/.laptop.local"
fi

pip install --upgrade pip pip-review
pip install virtualenv virtualenvwrapper


pip3 install --upgrade pip pip-review
pip3 install virtualenv virtualenvwrapper

pip install "ipython[all]"
pip3 install "ipython[all]"

pip install nose numpy scipy sympy pandas nltk 
pip3 install nose numpy scipy sympy pandas nltk 
python -c 'import numpy ; numpy.test();'
python -c 'import scipy ; scipy.test();'

brew install homebrew/python/matplotlib --with-cairo --with-tex

pip install matplotlib
pip install snakeviz pyzmq pygments q

pip3 install matplotlib
pip3 install snakeviz pyzmq pygments q

pip install --upgrade --no-cache-dir https://get.graphlab.com/GraphLab-Create/2.1/ruperttaryeenwind@gmail.com/your product key here/GraphLab-Create-License.tar.gz
pip3 install --upgrade --no-cache-dir https://get.graphlab.com/GraphLab-Create/2.1/ruperttaryeenwind@gmail.com/your product key here/GraphLab-Create-License.tar.gz
