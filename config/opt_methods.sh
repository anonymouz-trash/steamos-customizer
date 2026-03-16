#!/usr/bin/env bash

opt_packages(){
    clear
    echo -e "\n${white}[+] ${blue}Installing additional packages...${nocolor}\n"
    sleep 2

    read -p 'Do you want to edit pacman package list before installing? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        nano ./assets/opt_pkglist-pacman
    fi
    sudo pacman -S --needed - < <(grep -Ev '^[[:space:]]*(#|$)' ./assets/opt_pkglist-pacman)

    echo
    read -p "Press any key to resume ..."
}

opt_flatpaks(){
    clear
    echo -e "\n${white}[+] ${blue}Installing additional flatpak packages...${nocolor}\n"
    sleep 2

    read -p 'Do you want to edit flatpak package list before installing? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        nano ./assets/opt_pkglist-flatpak
    fi
    flatpak install - < <(grep -Ev '^[[:space:]]*(#|$)' ./assets/opt_pkglist-flatpak)

    echo
    read -p "Press any key to resume ..."
}

opt_nsl(){
    clear
    echo -e "\n${white}[+] ${blue}Launch NonSteamLaunchers On Steam Deck...${nocolor}\n"
    echo -e "${white}Don't worry this also works on Desktops. ;-)${nocolor}"
    sleep 2
    cd ~/.cache/arch-updater
    if [ -d NonSteamLaunchers-On-Steam-Deck ]; then
        cd NonSteamLaunchers-On-Steam-Deck
        git pull
        ./NonSteamLaunchers.sh
    else
        git clone https://github.com/moraroy/NonSteamLaunchers-On-Steam-Deck.git
        cd NonSteamLaunchers-On-Steam-Deck
        ./NonSteamLaunchers.sh
    fi
    cd ${pwd}
    echo
    read -p "Press any key to resume ..."
}

opt_wireguard(){
    clear
    echo -e "\n${white}[+] ${blue}Copy wireguard activate/deactivate script in /usr/local/sbin/wireguard-vpn${nocolor}\n"
    echo -e "${white}    Don't forget to put your wireguard profile in /etc/wireguard as wg0.conf${nocolor}\n"
	sleep 2
    if [ -f /usr/local/sbin/wireguard-vpn ]; then
        read -p 'Wireguard scripts already exists! Do you want to remove it? [y/N] ' input
        if [[ ${input} == "y" ]]; then
            sudo rm -v /usr/local/sbin/wireguard-vpn
            sudo rm -v /etc/NetworkManager/conf.d/dns.conf
            sudo systemctl disable --now systemd-resolved.service
            sudo ${pacman_cmd} -Rsnc systemd-resolvconf wireguard-tools
        fi
    else
        if ! ${pacman_cmd} -Qi systemd-resolvconf wireguard-tools &> /dev/null ; then
            sudo ${pacman_cmd} -S systemd-resolvconf wireguard-tools
        fi
        sudo cp ./assets/opt_wireguard-vpn.sh /usr/local/sbin/wireguard-vpn
        sudo cp ./assets/opt_wireguard-dns.conf /etc/NetworkManager/conf.d/dns.conf
    fi
    echo
    echo -e "\n${white}[+] ${blue}Reboot your system to let ${white}systemd-resolved & NetworkManager${blue} load properly${nocolor}\n"
    read -p "Press any key to resume ..."
}

opt_iptables(){
    clear
    echo -e "\n${white}[+] ${blue}Add preconfigured iptables ruleset script to /etc/iptables...${nocolor}\n"
    sleep 2
    if grep -qx "# Do not delete this file or edit this first comment! It is from arch-updater!" /etc/iptables/iptables.rules ; then
        read -p 'Iptables ruleset already exists! Do you want to remove it? [y/N] ' input
        if [[ ${input} == "y" ]]; then
            sudo systemctl disable --now iptables.service
            sudo rm -v /etc/iptables/iptables.rules
            sudo touch /etc/iptables/iptables.rules
            if ${pacman_cmd} -Q iptables-nft &> /dev/null ; then
                read -p 'Do you also want iptables itself to be removed? [y/N] ' input
                if [[ ${input} == "y" ]]; then
                    sudo ${pacman_cmd} -Rsnc iptables-nft
                fi
            fi
        fi
    else
        if ! ${pacman_cmd} -Q iptables-nft &> /dev/null ; then
            sudo ${pacman_cmd} -S iptables-nft
        fi
        sudo systemctl disable --now iptables.service
        read -p 'Do you want to edit iptables rulelist before installing? [y/N] ' input
        if [[ ${input} == "y" ]]; then
            nano ./assets/opt_iptables.rules
        fi
        sudo cp -v ./assets/opt_iptables.rules /etc/iptables/iptables.rules
        sudo systemctl enable --now iptables.service
    fi
    echo
    read -p "Press any key to resume ..."
}

opt_enable-pacman(){
    clear
    echo -e "\n${white}[+] ${blue}Enabling pacman ${purple}system-wide normally${blue}...${nocolor}\n"
    sleep 2
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
