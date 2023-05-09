#!/bin/sh

check_readme() {
  verification=

  while true
  do
    read -r -p "Did you read the README.md file? It's recommended to read the README.md file and verify the integrity of this verification script before continuing. [Y/n] " verification

    case $verification in
      [yY][eE][sS]|[yY]|"")
        printf "\nProceeding with verification...\n\n"
        break
        ;;
      [nN][oO]|[nN])
        printf "\nAlright come back when you have read the README.md file and verified the integrity of this script.\n"
        exit 1
        ;;
      *)
        printf "\nInvalid input...\n\n"
        ;;
    esac
  done
}

initial_instructions() {
  printf "To verify your Ledger Live install binary you need to download the following files:\n"
  printf "ledger-live-desktop-*.AppImage\n"
  printf "ledger-live-desktop-*.sha512sum\n"
  printf "ledgerlive.pem\n"
  printf "ledger-live-desktop-*.sha512sum.sig\n\n"
  printf "Here's a link to the Ledger Live signatures and releases page where you can download the above files:\n"
  printf "If you prefer to not share your IP address with Ledger, then use a trusted VPN or Tor when visiting their website to mask your IP address.\n"
  printf "https://www.ledger.com/ledger-live/lld-signatures\n\n"
  printf "The *'s in the file names above will be replaced by whatever version of Ledger Live you're verifying.\n"
  printf "Be sure to double check the link is bringing you to Ledger's official website!\n"
  printf "Also make sure you download the files to the same directory as the verification script.\n\n"
}

ledger_live_app_image=
ledger_live_sha512sum=
ledgerlive_pem=
ledger_live_sha512sum_sig=

check_for_file() {
  if compgen -G "$1" > /dev/null; then
    if [ "$1" == "ledger-live-desktop-*.AppImage" ]; then
      ledger_live_app_image=$(compgen -G "$1")
      printf "The $ledger_live_app_image is the binary installation file that we'll be verifying.\n\n"
    elif [ "$1" == "ledger-live-desktop-*.sha512sum" ]; then
      ledger_live_sha512sum=$(compgen -G "$1")
      printf "The $ledger_live_sha512sum file is the SHA512 hashes file.\n\n"
    elif [ "$1" == "ledgerlive.pem" ]; then
      ledgerlive_pem=$(compgen -G "$1")
      printf "The $ledgerlive_pem file is Ledger Live's OpenSSL public key (ECDSA) that is also embedded in the Ledger Live source code which you can view here:\n"
      printf "https://github.com/LedgerHQ/ledger-live-desktop/blob/master/src/main/updater/ledger-pubkey.js\n\n"
    elif [ "$1" == "ledger-live-desktop-*.sha512sum.sig" ]; then
      ledger_live_sha512sum_sig=$(compgen -G "$1")
      printf "The $ledger_live_sha512sum_sig file is the signature of the SHA512 hashes file.\n\n"
    fi
  else
    printf "$1 not found.\n"
    printf "Make sure to download the file to the same directory as the verification script.\n"
    exit 1
  fi
}

verify_binary_installation_file() {
  printf "To verify the authenticity of the Ledger Live binary installation file we'll verify its hash defined in the SHA512 hashes file.\n"

  if sha512sum --check $ledger_live_sha512sum --ignore-missing | grep -Fqx "$ledger_live_app_image: OK"; then
    printf "\nThe hashes matched!\n"
    printf "If you want to be certain the values actually match, then check the code and the hashes manually.\n\n"
    printf "You can also compare the SHA512 hash found in the SHA512 hashes file with the one available on Ledger's official website.\n\n"
  else
    printf "\nThe hashes did not match.\n"
    printf "Double check that you're using Ledger's official website and that you downloaded the correct Ledger Live binary installation and SHA512 hashes files.\n"
    printf "Also make sure the Ledger Live binary installation file name is in the following format: ledger-live-desktop-*.AppImage\n"
    exit 1
  fi
}

check_sha512_hashes() {
  printf "For extra security, we're going to also check that the SHA512 hashes published in the ledger-live-desktop-*.sha512sum file are indeed signed by Ledger.\n"
  printf "To do this we'll use the ledger-live-desktop-*.sha512sum file, the ledgerlive.pem file, and the ledger-live-desktop-*.sha512sum.sig file.\n\n"

  verification=$(openssl dgst -sha256 -verify $ledgerlive_pem -signature $ledger_live_sha512sum_sig $ledger_live_sha512sum)

  if [ "$verification" == "Verified OK" ]; then
    printf "$verification\n"
    printf "If you want to be certain the calculation is correct, then check the code.\n\n"
  else
    printf "\nThe verification was invalid.\n"
    printf "Be sure to double check that you downloaded all of the files correctly and that you're using Ledger's official website.\n"
    exit 1
  fi

  printf "Your Ledger Live download has been successfully verified!\n"
  printf "You're now ready to install Ledger Live!\n"
}

check_readme
initial_instructions
check_for_file "ledger-live-desktop-*.AppImage"
check_for_file "ledger-live-desktop-*.sha512sum"
check_for_file "ledgerlive.pem"
check_for_file "ledger-live-desktop-*.sha512sum.sig"
verify_binary_installation_file
check_sha512_hashes
