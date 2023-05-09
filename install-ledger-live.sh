#!/bin/bash

ledger_live_app_image=
ledger_live_icon=

check_verification() {
  verification=

  while true
  do
    read -r -p "Did you read the README.md file? It's recommended to read the README.md file, verify the integrity of this installation script, and verify the Ledger Live install binary before continuing. [Y/n] " verification

    case $verification in
      [yY][eE][sS]|[yY]|"")
        printf "\nProceeding with installation...\n\n"
        break
        ;;
      [nN][oO]|[nN])
        printf "\nAlright come back when you have read the README.md file, verified the integrity of this script, and verified the Ledger Live install binary which you can do by running the verify-ledger-live.sh script.\n"
        exit 1
        ;;
      *)
        printf "\nInvalid input...\n\n"
        ;;
    esac
  done
}

check_for_file() {
  if compgen -G "$1" > /dev/null; then
    if [ "$1" == "ledger-live-desktop-*.AppImage" ]; then
      ledger_live_app_image=$(compgen -G "$1")
      printf "Located the $ledger_live_app_image file.\n\n"
    elif [ "$1" == "ledger-live-icon.png" ]; then
      ledger_live_icon=$(compgen -G "$1")
      printf "Located the $ledger_live_icon file.\n\n"
    fi
  else
    printf "$1 not found.\n"
    printf "Make sure to download the file to the same directory as the installation script.\n"
    exit 1
  fi
}

check_sudo() {
  until $1
  do
    exit 1
    sleep 1
  done
}

set_up_sudo_session() {
  printf "Setting up sudo session...\n"
  check_sudo 'sudo -v'
}

make_file_executable() {
  printf "\nMaking the $ledger_live_app_image file executable.\n\n"
  chmod u+x $ledger_live_app_image
}

rename_file() {
  printf "Renaming the $ledger_live_app_image file to ledger-live.AppImage.\n\n"
  mv $ledger_live_app_image "ledger-live.AppImage"
  ledger_live_app_image="ledger-live.AppImage"
}

move_file_to_opt() {
  printf "Moving the $ledger_live_app_image file to /opt.\n\n"
  sudo mv $ledger_live_app_image /opt
}

make_symbolic_link() {
  printf "Making a symbolic link for the $ledger_live_app_image file in /opt to /usr/bin/ledger-live.\n\n"
  sudo ln -sf /opt/$ledger_live_app_image /usr/bin/ledger-live
}

move_icon() {
  printf "Moving the $ledger_live_icon file to $HOME/.local/share/icons.\n\n"
  if [ ! -d $HOME/.local/share/icons ]; then
    mkdir $HOME/.local/share/icons
  fi
  mv $ledger_live_icon $HOME/.local/share/icons
}

make_desktop_entry() {
  printf "Making a desktop entry for Ledger Live in /usr/share/applications/ledger-live.desktop with the following contents:\n\n"
  cat <<EOF | sudo tee /usr/share/applications/ledger-live.desktop
[Desktop Entry]
Type=Application
Name=Ledger Live
Comment=Ledger Live
Icon=$HOME/.local/share/icons/ledger-live-icon.png
Exec=ledger-live
Terminal=false
Categories=Finance;
EOF
}

how_to_run_app() {
  printf "\nLedger Live installation complete!\n\n"
  printf "You can launch Ledger Live from anywhere in the terminal using the following command:\n\n"
  printf "ledger-live\n\n"
  printf "You can also launch Ledger Live by clicking on the desktop entry.\n"
}

check_verification
check_for_file "ledger-live-desktop-*.AppImage"
check_for_file "ledger-live-icon.png"
set_up_sudo_session
make_file_executable
rename_file
move_file_to_opt
make_symbolic_link
move_icon
make_desktop_entry
how_to_run_app
