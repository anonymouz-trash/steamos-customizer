#!/usr/bin/env bash

cust_reversal(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating Reversal icon theme...${nocolor}\n"
	sleep 2
    cd ~/.cache/steamos-customizer
    if [ -d "$HOME/.local/share/icons/Reversal" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            ./Reversal-icon-theme/install.sh -u
            rm -rfv ./Reversal-icon-theme
            return
        else
            if [[ -d "Reversal-icon-theme" ]] ; then
                cd Reversal-icon-theme
                git pull
                cd ..
            fi
        fi
    else
        git clone https://github.com/yeyushengfan258/Reversal-icon-theme.git
    fi
    if [[ -d "Reversal-icon-theme" ]] ; then
        ./Reversal-icon-theme/install.sh -a -t all
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input
        if [[ ${input} == "y" ]]; then
            rm -rfv ./Reversal-icon-theme
        fi
    fi
    cd ${pwd}
    echo
    read -p "Press any key to resume ..."
}

cust_gtk_lavanda(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating Lavanda GTK theme...${nocolor}\n"
	sleep 2
	cd ~/.cache/steamos-customizer

	# Check if WhiteSur got pulled and is up to date
    if [ -d "Lavanda-gtk-theme" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            ./Lavanda-gtk-theme/install.sh -u
            rm -rf ./Lavanda-gtk-theme
        else
            cd Lavanda-gtk-theme
            git pull
            cd ..
        fi
    else
        git clone https://github.com/vinceliuice/Lavanda-gtk-theme.git
    fi
    if [[ -d "Lavanda-gtk-theme" ]]; then
        ./Lavanda-gtk-theme/install.sh
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input

        if [[ ${input} == "y" ]]; then
            rm -rf Lavanda-gtk-theme
        fi
    fi
    echo
    read -p "Press any key to resume ..."
    cd ${pwd}
}

cust_kde_lavanda(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating Lavanda KDE theme...${nocolor}\n"
	sleep 2
	cd ~/.cache/steamos-customizer

	# Check if WhiteSur got pulled and is up to date
    if [ -d "Lavanda-kde" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            ./Lavanda-kde/uninstall.sh
            rm -rfv ./Lavanda-kde
        else
            cd Lavanda-kde
            git pull
            cd ..
        fi
    else
        git clone https://github.com/vinceliuice/Lavanda-kde.git
    fi
    if [[ -d "Lavanda-kde" ]]; then
        ./Lavanda-kde/install.sh
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input
        if [[ ${input} == "y" ]]; then
            rm -rfv Lavanda-kde
        fi
    fi
    echo
    read -p "Press any key to resume ..."
    cd ${pwd}
}

cust_gtk_layan(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating Layan GTK theme...${nocolor}\n"
    sleep 2
    cd ~/.cache/steamos-customizer

    if [ -d "Layan-gtk-theme" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            sudo ./Layan-gtk-theme/install.sh -u
            rm -rfv ./Layan-gtk-theme
        else
            cd Layan-gtk-theme
            git pull
            cd ..
        fi
    else
        git clone https://github.com/vinceliuice/Layan-gtk-theme.git
    fi
    if [[ -d "Layan-gtk-theme" ]]; then
        ./Layan-gtk-theme/install.sh
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input

        if [[ ${input} == "y" ]]; then
            rm -rfv Layan-gtk-theme
        fi
    fi
    echo
    read -p "Press any key to resume ..."
    cd ${pwd}
}

cust_kde_layan(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating Layan KDE theme...${nocolor}\n"
	sleep 2
	cd ~/.cache/steamos-customizer

    if [ -d "Layan-kde" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            ./Layan-kde/uninstall.sh
            rm -rfv ./Layan-kde
        else
            cd Layan-kde
            git pull
            cd ..
        fi
    else
        git clone https://github.com/vinceliuice/Layan-kde.git
    fi
    if [[ -d "Layan-kde" ]]; then
        ./Layan-kde/install.sh
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input

        if [[ ${input} == "y" ]]; then
            rm -rfv Layan-kde
        fi
    fi
    echo
    read -p "Press any key to resume ..."
    cd ${pwd}
}

cust_gtk_whitesur(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating WhiteSur GTK theme...${nocolor}"
    if [[ ${de,,} =~ "gnome" ]]; then
        echo -e "\n${white}[+] ${blue}!!!${nocolor} Please use background pictures without spaces in the filename ${blue}!!!${nocolor}\n"
    fi
    sleep 2
    cd ~/.cache/steamos-customizer
    if [ -d "WhiteSur-gtk-theme" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            sudo ./WhiteSur-gtk-theme/install.sh -r
            rm -rfv ./WhiteSur-gtk-theme
        else
            cd WhiteSur-gtk-theme
            git pull
            cd ..
        fi
    else
        git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
    fi
    if [ -d "WhiteSur-gtk-theme" ]; then
        ./WhiteSur-gtk-theme/install.sh -m -o normal -t all
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input

        if [[ ${input} == "y" ]]; then
            rm -rfv WhiteSur-gtk-theme
        fi
    fi
    echo
    read -p "Press any key to resume ..."
}

cust_kde_whitesur(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating WhiteSur KDE theme...${nocolor}"
    sleep 2
    cd ~/.cache/steamos-customizer
    if [ -d "WhiteSur-kde" ]; then
        read -p "Do you want to (r)emove or just update it? [r/U] " input
        if [[ ${input} == "r" ]]; then
            ./WhiteSur-kde/uninstall.sh
            rm -rfv ./WhiteSur-kde
        else
            cd WhiteSur-kde
            git pull
            cd ..
        fi
    else
        git clone https://github.com/vinceliuice/WhiteSur-kde.git
    fi
    if [ -d "WhiteSur-kde" ]; then
        ./WhiteSur-kde/install.sh
        echo
        echo
        echo "Do you want to remove previously downloaded files? "
        read -p "Type (n) or just press [Enter] if you want to update in the future [y/N] " input

        if [[ ${input} == "y" ]]; then
            rm -rf WhiteSur-kde
        fi
    fi
    echo
    read -p "Press any key to resume ..."
}

cust_bibata(){
    clear
    echo -e "\n${white}[+] ${blue}Installing or updating Bibata cursor theme...${nocolor}\n"
    sleep 2
    cd ~/.cache/steamos-customizer
    if [ -d "Bibata" ]; then
        read -p "Do you want to (r)emove it? [y/N] " input
        if [[ ${input} == "r" ]]; then
            rm -rfv ./Bibata
            rm -rfv $HOME/.local/share/icons/Bibata*
        fi
    fi
    if ! [ -d "Bibata" ]; then
        mkdir Bibata
    fi
    cd Bibata
    if ! [ -f Bibata.tar.xz ]; then
        wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata.tar.xz
    fi
    tar -xvf Bibata.tar.gz
    mv Bibata-* ~/.local/share/icons/
    echo
    read -p "Press any key to resume ..."
}

cust_fastfetch(){
    clear
    echo -e "\n${white}[+] ${blue}Installing / Removing fastfetch...${nocolor}\n"
	sleep 2
	if [ "$(pacman -Qe bash | wc -l)" -ge 1 ] | [ "$(pacman -Qe bash | wc -l)" -ge 1 ] ; then
        echo -e "\n${white}[+] ${cyan}Neither BASH or ZSH are installed, aborting...${nocolor}\n"
        sleep 2
    else
        if [ "$(pacman -Qe fastfetch | wc -l)" -ge 1 ]; then
            read -p "Already installed! Do you want to (r)emove it? [r/N] " input
            if [[ ${input} == "r" ]]; then
                sudo pacman -Rsnc fastfetch
                rm -rf ~/.config/fastfetch
                if [[ ${SHELL,,} =~ "bash" ]]; then
                    grep -v 'echo ""'  ~/.bashrc > ~/.tmp_user_bashrc
                    sudo mv ~/.tmp_user_bashrc  ~/.bashrc
                    grep -v "customcfg.jsonc"  ~/.bashrc > ~/.tmp_user_bashrc
                    sudo mv ~/.tmp_user_bashrc  ~/.bashrc
                fi
            fi
        else
            sudo pacman -S fastfetch
            cd assets
            mkdir ~/.config/fastfetch
            if [[ "${system_os}" == "SteamOS" ]]; then
                cp cust_steamos.jsonc ~/.config/fastfetch/customcfg.jsonc
            fi
            if [[ ${SHELL,,} =~ "bash" ]]; then
                echo "${white}Identified standard shell: ${blue}BASH${nocolor}"
                echo 'echo ""' >> ~/.bashrc
                echo "fastfetch -c ~/.config/fastfetch/customcfg.jsonc" >> ~/.bashrc
                echo 'echo ""' >> ~/.bashrc
            fi
        fi
    fi
    echo
    read -p "Press any key to resume ..."
}
