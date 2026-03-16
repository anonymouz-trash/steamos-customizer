#!/usr/bin/env bash
# Get the directory from which the script is started
# This is useful if you plan to start the script via global hotkey
# because of the assets and the the use of relative paths
# pwd=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# colors section
blue='\033[1;34m'
cyan='\033[1;36m'
magenta='\033[1;35m'
red='\033[1;31m'
white='\033[1;37m'
nocolor='\033[0m'

# check current desktop
de=$XDG_CURRENT_DESKTOP

# check current linux system
if grep -q "steamos" /etc/os-release; then
    system_os="SteamOS"
elif grep -q "Arch Linux" /etc/os-release; then
    system_os="Arch Linux"
elif grep -q "CachyOS" /etc/os-release; then
    system_os="CachyOS"
elif grep -q "EndeavourOS" /etc/os-release; then
    system_os="EndeavourOS"
elif grep -q "Manjaro" /etc/os-release; then
    system_os="Manjaro"
elif grep -q "Garuda" /etc/os-release; then
    system_os="Garuda Linux"
else
    system_os="Something else (use at your own risk)"
fi

draw_logo() {
    echo -e "${blue}"
    cat << "EOF"

 ___ _                  ___  ___    ___        _             _
/ __| |_ ___ __ _ _ __ / _ \/ __|  / __|  _ __| |_ ___ _ __ (_)______ _ _
\__ \  _/ -_) _` | '  \ (_) \__ \ | (_| || (_-<  _/ _ \ '  \| |_ / -_) '_|
|___/\__\___\__,_|_|_|_\___/|___/  \___\_,_/__/\__\___/_|_|_|_/__\___|_|
EOF
    echo -e "${nocolor}"
}

draw_menu() {
    echo -e "${white}"
    cat << "EOF"
========================================================================

  1) Update SteamOS
  2) Update Flatpaks

  3) Enable "sudo"
  4) (Re-)Enable Pacman
  5) Install Pacman packages
  6) Install Flatpak packages

  7) Install iptables ruleset (for Ethernet, WLAN, Wireguard & Qemu)
  8) Copy Wireguard start script

  9) SteamOS plugin section (like Decky Loader, EmuDeck, NSL, ...)
 10) KDE Themeing section


  q) Exit

========================================================================
EOF
    echo -e "${nocolor}"
}

draw_theme_menu() {
    echo -e "${white}"
    cat << "EOF"
========================================================================

  [ CURSOR ]                        [ GTK ]

    1) Bibata                         4) Lavanda
                                      5) Layan
  [ ICON ]                            6) WhiteSur

    2) Reversal                     [ KDE ]

  [ TERMINAL ]                        7) Lavanda
                                      8) Layan
    3) Fastfetch                      9) WhiteSur


  b) Back
  q) Exit

========================================================================
EOF
    echo -e "${nocolor}"
}

draw_plugin_menu() {
    echo -e "${white}"
    cat << "EOF"
========================================================================

  1) Decky Loader
  2) EmuDeck
  3) Non-Steam-Launcher


  b) Back
  q) Exit

========================================================================
EOF
    echo -e "${nocolor}"
}
