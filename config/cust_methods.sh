#!/usr/bin/env bash

cust_reversal(){
    clear
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating Reversal icon theme...${nocolor}\n"
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
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating Lavanda GTK theme...${nocolor}\n"
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
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating Lavanda KDE theme...${nocolor}\n"
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
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating Layan GTK theme...${nocolor}\n"
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
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating Layan KDE theme...${nocolor}\n"
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
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating WhiteSur GTK theme...${nocolor}"
    if [[ ${de,,} =~ "gnome" ]]; then
        echo -e "\n${white}[+] ${blue}!!!${nocolor} Please use background pictures without spaces in the filename ${blue}!!!${nocolor}\n"
    fi
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
    cd ${pwd}
    read -p "Press any key to resume ..."
}

cust_kde_whitesur(){
    clear
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating WhiteSur KDE theme...${nocolor}"
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
    cd ${pwd}
    read -p "Press any key to resume ..."
}

cust_bibata(){
    clear
    draw_logo
    echo -e "\n${white}[+] ${blue}Installing or updating Bibata cursor theme...${nocolor}\n"
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
    tar -xvf Bibata.tar.xz
    mv Bibata-* ~/.local/share/icons/
    echo
    cd ${pwd}
    read -p "Press any key to resume ..."
}
