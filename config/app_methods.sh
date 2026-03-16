#!/usr/bin/env bash

update_steamos(){
    clear
    echo -e "\n${white}[+] ${blue}Running SteamOS updates...${nocolor}\n"
    sleep 2
    steamos-update
    echo
    read -p "Press any key to resume ..."
}

update_flatpaks(){
    clear
    echo -e "\n${white}[+] ${blue}Running Flatpak updates...${nocolor}\n"
    sleep 2
    flatpak update
    echo
    read -p "Press any key to resume ..."
}

update_pacman(){
    clear
    echo -e "\n${white}[+] ${blue}Running Pacman updates...${nocolor}\n"
    sleep 2
    sudo pacman -Syu
    echo
    read -p "Press any key to resume ..."
}

clean_steamos(){
    clear
	echo -e "\n${white}[+] ${blue}Cleaning SteamOS...${nocolor}\n"
    cache_size=$(du -sh ~/.cache)
    paccache_size=$(du -sh /var/cache/pacman/pkg)
    flatpak_size=$(du -sh ~/.cache/flatpak)
    sleep 2
	echo -e "${cyan} Size of current user's cache: ${nocolor}  ${cache_size}\n"
	echo -e "${cyan} Size of pacman cache:         ${nocolor}  ${paccache_size}\n"
	echo -e "${cyan} Size of flatpak cache:        ${nocolor}  ${flatpak_size}\n"
    echo
    read -p 'Do you want to clear all (y) cached pacman packages or just the ones that are not installed (N)? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        sudo pacman -Scc
    else
        sudo pacman -Sc
    fi
    echo
    read -p 'Do you want to remove all unused flatpak packages, like orphaned runtimes or old SDKs? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        flatpak uninstall --unused --user
    fi
    unused=$(pacman -Qtdq)
    if [ "$(echo ${unused} | wc -l)" -ge 2 ]; then
        echo -e "\n${cyan} This is a list of packages not used by anyone... ${nocolor}\n"
        echo -e "${red}${unused}${nocolor}\n"
        read -p 'Do you want to remove these packages? [y/N] ' input
        if [[ ${input} == "y" ]]; then
            sudo pacman -Rnsc $(yay -Qtdq)
        fi
    fi
    echo
    read -p 'Do you want to delete the contents of ~/.cache directory? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        rm -rfv ~/.cache/*
    fi
    clear
    cache_size=$(du -sh ~/.cache)
    paccache_size=$(du -sh /var/cache/pacman/pkg)
    flatpak_size=$(du -sh ~/.cache/flatpak)
    echo
    echo -e "${cyan} Size of current user's cache: ${nocolor}  ${cache_size}\n"
    echo -e "${cyan} Size of pacman cache:         ${nocolor}  ${paccache_size}\n"
    echo -e "${cyan} Size of flatpak cache:        ${nocolor}  ${flatpak_size}\n"
    echo
    read -p "Press any key to resume ..."
    unset paccache_size cache_size flatpak_size unused input
}

enable_sudo(){
    clear
    echo -e "\n${white}[+] ${blue}Enable (or change) the 'sudo' password...${nocolor}\n"
    sleep 2
    passwd
    echo
    read -p "Press any key to resume ..."
}
