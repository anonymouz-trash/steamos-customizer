#!/usr/bin/env bash

### Enable debugging
# set -Eeuo pipefail
# trap 'echo "ERROR in $0:${LINENO}: $BASH_COMMAND" >&2' ERR
# PS4='+ ${BASH_SOURCE}:${LINENO}: '
# set -x


### Declare environment variables

# User home directory
app_home=$HOME

# Get the directory from which the script is started
# This is useful if you plan to start the script via global hotkey
# because of the assets and the the use of relative paths
app_pwd=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${app_pwd}"

### Include required functions
for f in ./config/{app_functions,app_methods,cust_methods,opt_methods}.sh; do
  [[ -f $f ]] || { echo "Missing $f" >&2; exit 1; }
  source "$f"
done

if ! [[ "${system_os}" == "SteamOS" ]]; then
    echo "You're not running SteamOS!"
    echo ""
    echo "Detected system: ${system_os}"
    echo ""
    echo -e "${red}Use at your own risk!${nocolor}"
fi

while true; do
    clear
    # Check if steamos-customizer cache directory exists
    if ! [ -d "$HOME/.cache/steamos-customizer" ]; then
        mkdir -p ~/.cache/steamos-customizer
    fi
    draw_logo
    draw_menu
    read -rp "Choice: " choice

    case $choice in
        1)
            update_steamos
            ;;
        2)
            update_flatpaks
            ;;
        3)
            opt_enable-pacman
            ;;
        4)
            opt_packages
            ;;
        5)
            opt_iptaples
            ;;
        6)
            opt_wireguard
            ;;
        7)
            clear
            draw_logo
            draw_plugin_menu
            read -rp "Choice: " choice

            case $choice in
                1)
                    install_decky
                    ;;
                2)
                    install_emudeck
                    ;;
                3)
                    install_nsl
                    ;;
                b)
                    continue
                    ;;
                q)
                    echo "Bye"
                    exit 0
                    ;;
                *)
                    echo "Incorrect choice..."
                    sleep 1
                    ;;
            esac
            ;;
        8)
            clear
            draw_logo
            draw_theme_menu
            read -rp "Choice: " choice

            case $choice in
                1)
                    cust_bibata
                    ;;
                2)
                    cust_reversal
                    ;;
                3)
                    cust_fastfetch
                    ;;
                4)
                    cust_gtk_lavanda
                    ;;
                5)
                    cust_gtk_layan
                    ;;
                6)
                    cust_gtk_whitesur
                    ;;
                7)
                    cust_kde_lavanda
                    ;;
                8)
                    cust_kde_layan
                    ;;
                9)
                    cust_kde_whitesur
                    ;;
                b)
                    continue
                    ;;
                q)
                    echo "Bye"
                    exit 0
                    ;;
                *)
                    echo "Incorrect choice..."
                    sleep 1
                    ;;
            esac
            ;;
        q)
            echo "Bye"
            exit 0
            ;;
        *)
            echo "Incorrect choice..."
            sleep 1
            ;;
    esac
done
