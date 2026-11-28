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

git fetch origin

if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/$(git branch --show-current))" ]; then
    update_needed=1
else
    update_needed=0
fi

draw_logo() {
    echo -e "${blue}"
    cat << "EOF"

   ______                 ____  ____  _____         __             _
  / __/ /____ ___ ___ _  / __ \/ __/ / ___/_ _____ / /____  __ _  (_)__ ___ ____
 _\ \/ __/ -_) _ `/  ' \/ /_/ /\ \  / /__/ // (_-</ __/ _ \/  ' \/ /_ // -_) __/
/___/\__/\__/\_,_/_/_/_/\____/___/  \___/\_,_/___/\__/\___/_/_/_/_//__/\__/_/
EOF
    echo -e "${nocolor}"
}

draw_menu() {
    echo -e "${white}"
    cat << "EOF"
========================================================================

  1) Update SteamOS
  2) Update Flatpaks
  3) Clean SteamOS                (unused pacman + flatpak cache, etc.)

  4) >> System section            (Pacman, Flatpak, Wireguard)
  5) >> SteamOS plugin section    (like Decky Loader, EmuDeck, NSL, ...)
  6) >> KDE Themeing section



  q) Exit

========================================================================
EOF
    echo -e "${nocolor}"
}

draw_system_menu() {
    echo -e "${white}"
    cat << "EOF"
========================================================================

  1) Enable (or change) the "sudo" password
  2) (Re-)Enable Pacman
  3) Install Pacman packages
  4) Install Flatpak packages

  5) Install firewall-cmd ruleset (for WLAN & Wireguard)
  6) Add Wireguard config to NetworkManager (+ start/stop script)
  7) Add NFS share toggle script & shortcuts

  8) Create desktop shortcut for Steam Customizer

  b) Back
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

    1) Bibata                         3) Lavanda
                                      4) Layan
  [ ICON ]                            5) WhiteSur

    2) Reversal                     [ KDE ]

                                      6) Lavanda
                                      7) Layan
                                      8) WhiteSur


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

  4) GyroDSU (Steam Deck)
  5) GyroDSU (Steam Controller)
  6) GyroDSU (Combined Service)

  7) CryoUtilities

  b) Back
  q) Exit

========================================================================
EOF
    echo -e "${nocolor}"
}
