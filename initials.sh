#!/bin/bash

# Update and upgrade system
sudo apt update
sudo apt upgrade -y

# List of packages to install
packages=(
    "code"
    "gnome-tweaks"
    "gparted"
    "gimp"
    "inkscape"
    "thunderbird"
    "discord"
    "filezilla"
    "vlc"
    "git"
    "docker.io"
    "nodejs"
    "snapd"
    "tldr"
    "obs-studio"
    "wireshark"
)

# Install packages using a for loop
for package in "${packages[@]}"; do
    sudo apt install -y "$package"
done


# Install parse_git_branch function in .bashrc
echo '
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"
}
if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\] \$(parse_git_branch)\[\033[00m\]\$ "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$(parse_git_branch)\$ "
fi
' >> ~/.bashrc

# Reload .bashrc to apply changes
source ~/.bashrc


# Download and install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -f install -y

# Install Postman using snap
sudo snap install postman

# Install Brave Browser using snap
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser -y

# Clean up
rm google-chrome-stable_current_amd64.deb

echo "All packages installed successfully."