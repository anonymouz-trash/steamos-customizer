#!/usr/bin/env bash

opt_packages(){
    echo -e "\n${white}[+] ${blue}Installing additional packages...${nocolor}\n"
    read -p 'Do you want to edit pacman package list before installing? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        nano ./assets/opt_pkglist-pacman
    fi
    sudo pacman -S --needed - < <(grep -Ev '^[[:space:]]*(#|$)' ./assets/opt_pkglist-pacman)
    echo
    read -p "Press any key to resume ..."
}

opt_flatpaks(){
    echo -e "\n${white}[+] ${blue}Installing additional flatpak packages...${nocolor}\n"
    read -p 'Do you want to edit flatpak package list before installing? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        nano ./assets/opt_pkglist-flatpak
    fi
    # Resolve a short name (e.g. "gimp") to a full Flatpak app ID via flathub
    resolve_flatpak_id() {
        local name="$1"
        # Already a full ID (contains a dot) -> use as-is
        [[ "$name" == *.* ]] && { print -r -- "$name"; return 0; }

        # Search flathub, match the application ID's last segment case-insensitively
        flatpak remote-ls --user --app --columns=application flathub 2>/dev/null \
            | grep -i -m1 -E "\.${name}\$"
    }
    while read -r app; do
        id="$(resolve_flatpak_id "$app")"
        if [[ -z "$id" ]]; then
            echo "Could not resolve Flatpak: $app" >&2
            continue
        fi
        flatpak install --user -y flathub "$id" < /dev/null
    done < <(grep -Ev '^[[:space:]]*(#|$)' ./assets/opt_pkglist-flatpak)
    echo
    read -p "Press any key to resume ..."
}

install_nsl(){
    echo -e "\n${white}[+] ${blue}Install NonSteamLaunchers On Steam Deck...${nocolor}\n"
    cd ~/.cache/steamos-customizer
    /bin/bash -c 'export logged_in_home=$(eval echo "~$(whoami)"); curl -Ls https://raw.githubusercontent.com/moraroy/NonSteamLaunchers-On-Steam-Deck/main/NonSteamLaunchers.sh | nohup /bin/bash'
    cd ${pwd}
    echo
    read -p "Press any key to resume ..."
}

install_decky(){
    echo -e "\n${white}[+] ${blue}Install Decky Loader...${nocolor}\n"
    cd ~/.cache/steamos-customizer
    sh -c 'rm -f /tmp/user_install_script.sh; if curl -S -s -L -O --output-dir /tmp/ --connect-timeout 60 https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/user_install_script.sh; then bash /tmp/user_install_script.sh; else echo "Something went wrong, please report this if it is a bug"; read; fi'
    echo
    cd ${pwd}
    read -p "Press any key to resume ..."
}

install_emudeck(){
    echo -e "\n${white}[+] ${blue}Install EmuDeck...${nocolor}\n"
    if [ -f "$HOME/Applications/EmuDeck.AppImage" ]; then
        echo -e "\n${white}[+] ${blue}EmuDeck already installed, starting it...${nocolor}\n"
        $HOME/Applications/EmuDeck.AppImage
    else
        cd ~/.cache/steamos-customizer
        sh -c 'curl -L https://raw.githubusercontent.com/dragoonDorise/EmuDeck/main/install.sh | bash'
        echo
        cd ${pwd}
    fi
    read -p "Press any key to resume ..."
}

opt_wireguard(){
    echo -e "\n${white}[+] ${blue}Copy wireguard activate/deactivate script to ${apphome}/local/bin/wireguard-vpn${nocolor}\n"
    if [ -f "${apphome}/.local/bin/wireguard-vpn" ]; then
        read -r -p 'WireGuard script already exists! Do you want to remove it? [y/N] ' input
        if [[ "${input}" == "y" || "${input}" == "Y" ]]; then
            # Bring the VPN down first if it is currently active
            if nmcli -t -f NAME connection show --active | grep -qxF "WireGuard VPN"; then
                nmcli connection down id "WireGuard VPN"
            fi
            # Remove the NetworkManager connection (only if it exists)
            if nmcli -t -f NAME connection show | grep -qxF "WireGuard VPN"; then
                nmcli connection delete id "WireGuard VPN"
                echo -e "${white}[+] ${blue}NetworkManager connection removed${nocolor}"
            else
                echo -e "${white}[+] ${blue}No NetworkManager connection named 'WireGuard VPN' found${nocolor}"
            fi
            # Remove the toggle script
            rm -v "${apphome}/.local/bin/wireguard-vpn"
            # Optionally remove the PATH line that the installer added to .bashrc
            path_line='export PATH="$HOME/.local/bin:$PATH"'
            if grep -qxF "${path_line}" "${apphome}/.bashrc" 2>/dev/null; then
                echo
                read -r -p 'Also remove the ~/.local/bin PATH entry from .bashrc? [y/N] ' input
                if [[ "${input}" == "y" || "${input}" == "Y" ]]; then
                    cp "${apphome}/.bashrc" "${apphome}/.bashrc.bak"
                    grep -vxF "${path_line}" "${apphome}/.bashrc.bak" > "${apphome}/.bashrc"
                    echo -e "${white}[+] ${blue}PATH entry removed (backup: ${apphome}/.bashrc.bak)${nocolor}"
                fi
            fi
        fi
    else
        echo
        read -p "Please provide wg0.conf in import folder of the script and press any key to continue ..."
        echo
        if [ -f ./import/wg0.conf ]; then
            nmcli connection import type wireguard file ./import/wg0.conf
            nmcli connection modify wg0 connection.id "WireGuard VPN"
            mkdir -p "${apphome}/.local/bin"
            cp -v ./assets/opt_wireguard-vpn.sh ${apphome}/.local/bin/wireguard-vpn
            # Make sure ~/.local/bin is in PATH for interactive shells
            if ! grep -qs '\.local/bin' "${apphome}/.bashrc"; then
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> "${apphome}/.bashrc"
                echo
                echo -e "${white}[+] ${blue}Added ~/.local/bin to PATH in ${apphome}/.bashrc${nocolor}"
            fi
        else
            echo
            echo -e "\n${red}[+] ${white}./import/wg0.conf not found! Start again.${nocolor}\n"
        fi
    fi
    echo
    read -p "Press any key to resume ..."
}

opt_firewall(){
    echo -e "\n${white}[+] ${blue}Add preconfigured iptables ruleset script to /etc/iptables...${nocolor}\n"
    FW="sudo firewall-cmd --permanent"
    # --- Default zone (replaces INPUT policy DROP) ---------------------------
    # All interfaces without an explicit zone (wlan0, enp2s0) land in "drop":
    # incoming traffic is dropped, replies to outgoing connections are still
    # allowed via connection tracking (ESTABLISHED,RELATED).
    $FW --set-default-zone=drop
    # --- WireGuard (replaces: -A INPUT/OUTPUT -i/-o wg0 -j ACCEPT) -----------
    $FW --new-zone=vpn
    $FW --zone=vpn --set-target=ACCEPT
    $FW --zone=vpn --add-interface=wg0
    firewall-cmd --reload
    echo
    read -p "Press any key to resume ..."
}

opt_enable-pacman(){
    echo -e "\n${white}[+] ${blue}Enabling pacman ${purple}system-wide normally${blue}...${nocolor}\n"
    sudo steamos-readonly disable
    if [ -d /etc/pacman.d/gnupg ]; then
        sudo rm -rfv /etc/pacman.d/gnupg
    fi
    sudo pacman-key --init
    sudo pacman-key --populate archlinux
    sudo pacman-key --populate holo
    sudo pacman -Syu
    #sudo steamos-readonly enable
    echo
    read -p "Press any key to resume ..."
}

opt_gyrodsu-steamdeck(){
    echo -e "\n${white}[+] ${blue}Enabling GyroDSU for ${purple}Steam Deck${blue}...${nocolor}\n"
    bash <(curl -sL https://raw.githubusercontent.com/kmicki/SteamDeckGyroDSU/master/pkg/update.sh)
    echo
    read -p "Press any key to resume ..."
}

opt_gyrodsu-steamcontroller(){
    echo -e "\n${white}[+] ${blue}Enabling GyroDSU for ${purple}Steam Controller${blue}...${nocolor}\n"
    bash <(curl -sL https://raw.githubusercontent.com/dylangmarinus-stack/Steam-Controller-GyroDSU/main/pkg/install.sh)
    echo
    read -p "Press any key to resume ..."
}

opt_gyrodsu-combined(){
    echo -e "\n${white}[+] ${blue}Enabling GyroDSU for ${purple}Steam Controller${blue}...${nocolor}\n"
    cd ~/.cache/steamos-customizer
    git clone https://github.com/korph-jz/steamdeck-dsu-combiner.git
    cd steamdeck-dsu-combiner
    ./install.sh
    echo
    read -p "Press any key to resume ..."
}
