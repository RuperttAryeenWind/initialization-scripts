brew tap caskroom/cask;
brew install brew-cask;

brew update;

brew cask install java;
brew install Caskroom/versions/java7
brew install Caskroom/versions/java6

brew install jenv

# Init jenv
echo 'if which jenv > /dev/null; then eval "$(jenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

jenv add /Library/Java/JavaVirtualMachines/jdk1.7.0_*.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_*.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/

jenv versions

jenv global 1.8
