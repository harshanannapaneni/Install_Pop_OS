#!/bin/bash

read -p "Want the themes local or global? Enter 1 for local, 2 for global (All Users): " choice

if [[ $choice == 1 ]]; then
    target_dir="$HOME/.themes"
elif [[ $choice == 2 ]]; then
    target_dir="/usr/share/themes"
else
    echo "Invalid choice. Exiting."
    exit 1
fi

if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

cd "$target_dir"

# Clone Dracula theme
git clone https://github.com/dracula/gtk.git

# Activate Dracula theme
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

echo "Drakula theme installed successfully"

# Install Kora Icon theme
if [[ $choice == 1 ]]; then
    # Clone Kora to our local repo
    git clone https://github.com/bikass/kora.git
    cd kora/
    cp -r kora "$HOME/.icons"
    cd ..
    rm -rf kora
    gsettings set org.gnome.desktop.interface icon-theme "kora"
elif [[ $choice == 2 ]]; then
    # Clone Kora to system-wide directory
    sudo git clone https://github.com/bikass/kora.git
    sudo cp -r kora /usr/share/icons
    sudo rm -rf kora
    gsettings set org.gnome.desktop.interface icon-theme "kora"
fi

echo "Kora icon pack/theme successfully installed"

echo "All the themes are installed successfully."

