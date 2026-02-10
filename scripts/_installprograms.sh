#!/usr/bin/env bash

# installs a bunch of my most commonly used programs
# Assumes you're on omarchy

sudo pacman -Syu fish ripgrep flatpak kanata pacman-contrib strawberry yazi rust-analyzer kid3 qt6ct kvantum bluez-utils kdenlive kdeconnect zathura zathura-pdf-mupdf

# Install zen browser and make it default browser
flatpak install flathub app.zen_browser.zen
xdg-settings set default-web-browser app.zen_browser.zen.desktop
# just to make sure
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/https
xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/http

xdg-mime default org.pwmt.zathura.desktop application/pdf
