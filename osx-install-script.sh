#!/bin/sh

# ~/.profile from http://furbo.org/2014/09/03/the-terminal/
echo '
alias ll="ls -lahL"
alias con="tail -40 -f /var/log/system.log"
alias dev="cd ~/dev/"

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export EDITOR="vim"
export CLICOLOR=1
export XCODE="`xcode-select --print-path`"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin"
' >> ~/.profile

# first, install xcode command line dev tools
xcode-select --install

# then, brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew doctor
brew doctor # because

brew update
brew upgrade

brew install git
brew install coreutils # Install GNU core utilities (those that come with OS X are outdated)
brew install bash
brew install ffmpeg
brew install imagemagick
brew install mitmproxy
brew install node
brew install tree
brew install wget
brew install nmap
brew install youtube-dl

brew install fish
brew cleanup
brew doctor

# config git
git config --global user.name "Vishnu Prem"
git config --global user.email "vishnu@vishnuprem.com"

# config fish
sudo -s 'echo "/usr/local/bin/fish" >> /etc/shells'
chsh -s /usr/local/bin/fish

# terminal case-insensitive tab completion
echo "set completion-ignore-case On" >> ~/.inputrc

# brew cask
brew install caskroom/cask/brew-cask

# cask apps
apps=(
	acorn
	air-video-server
	airserver
	alfred
	bbedit
	dash
	dropbox
	eclipse-java
	firefox
	flux
	github
	google-chrome
	hazel
	hipchat
	intellij-idea
	mailbox
	omnifocus
	onepassword
	quickcast
	quicklook-json
	rescuetime
	screens-connect
	sketch
	skype
	slack
	sourcetree
	spectacle
	spotify
	sublime-text3
	superduper
	textexpander
	textmate
	things
	transmission
	transmit
	vagrant
	vlc
	vmware-fusion
	xscope
)

# cask apps to /Applications
echo "Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}
brew cask cleanup

# tiny cask alfred fix
brew cask alfred link

###############################################################################
# Tweaks                                                               		  #
# Adapted from https://github.com/mathiasbynens/dotfiles/blob/master/.osx     #
###############################################################################

# ask for sudo
sudo -v

# keep sudo alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# set computer name
name="$(scutil --get ComputerName)"
echo "Enter the computer name [$name]: \c"
read name
COMPUTER_NAME="$name"
NETBIOS_NAME="$(echo $name | sed 's/ /\-/g; s/\-\-/\-/g' | tr -d "'")"
sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName $NETBIOS_NAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $NETBIOS_NAME

###############################################################################
# General UI/UX                                                               #
###############################################################################

# check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# enabling full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

###############################################################################
# Screen                                                                      #
###############################################################################

# require password immediately after sleep or screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# remove all apps from dock
defaults write com.apple.dock persistent-apps -array ""

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Put display to sleep
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

echo "Don't forget to go to your AppStore purchases tab and download a bunch of your stuff"

# dev stuff

# install cocoapods
sudo gem install cocoapods
