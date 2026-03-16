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

clean_arch(){
    clear
	echo -e "\n${white}[+] ${blue}Cleaning Arch Linux...${nocolor}\n"
    cache_size=$(du -sh ~/.cache)
    paccache_size=$(du -sh /var/cache/pacman/pkg)
    sleep 2
	echo -e "${cyan} Size of current user's cache: ${nocolor}  ${cache_size}\n"
	echo -e "${cyan} Size of pacman cache:         ${nocolor}  ${paccache_size}\n"
    echo
    read -p 'Do you want to clear all (y) cached packages or just the ones that are not installed (N)? [y/N] ' input
    if [[ ${input} == "y" ]]; then
        sudo pacman -Scc
    else
        sudo pacman -Sc
    fi
    unused=$(pacman -Qtdq)
    if [ "$(echo ${unused} | wc -l)" -ge 1 ]; then
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
    echo
    echo -e "${cyan} Size of current user's cache: ${nocolor}  ${cache_size}\n"
    echo -e "${cyan} Size of pacman cache:         ${nocolor}  ${paccache_size}\n"
    echo
    read -p "Press any key to resume ..."
    unset paccache_size cache_size unused input
}

installed_packages(){
    # Check if pacgraph is installed
    if ! command -v pacgraph &> /dev/null; then
        echo -e "\n${white}[+] ${blue}Pacgraph is not installed, installing...${nocolor}\n"
        sudo pacman -S pacgraph
    fi

    # Temporary file
    TMPFILE=$(mktemp)

    # Run pacgraph for explicits with console summary
    pacgraph -c -e > "$TMPFILE" 2>/dev/null

    # Filter only lines starting with a number and overwrite TMPFILE
    grep -E '^[0-9]' "$TMPFILE" > "${TMPFILE}.clean"

    # Show all output in dialog textbox
    dialog --title "Pacgraph Package Size Summary" --textbox "${TMPFILE}.clean" 35 95

    # Clean up
    rm "$TMPFILE" "${TMPFILE}.clean"
}
