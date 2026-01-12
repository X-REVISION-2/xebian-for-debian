#!/bin/bash

# Define an escape character variable for readability
ESC=$(printf "\e")
# Define a reset code to return to default terminal colors
RESET="${ESC}[0m"
# Format: \e[38;2;R;G;Bm
PURPLE_1_FG="${ESC}[38;2;103;58;183m"
PURPLE_2_FG="${ESC}[38;2;93;52;165m"
PURPLE_3_FG="${ESC}[38;2;82;46;146m"
PURPLE_4_FG="${ESC}[38;2;72;41;128m"
PURPLE_5_FG="${ESC}[38;2;62;35;110m"
PURPLE_6_FG="${ESC}[38;2;52;29;92m"
PURPLE_7_FG="${ESC}[38;2;41;23;73m"
PURPLE_8_FG="${ESC}[38;2;31;17;55m"
GREEN_01_FG="${ESC}[38;2;31;200;0m"
# Desktop env with xdg
DE_NAME=$XDG_CURRENT_DESKTOP

printf '\e[9;1t'        # maximize window
clear

printf "${PURPLE_1_FG}" 
printf ' /$$   /$$ /$$$$$$$$ /$$$$$$$  /$$$$$$  /$$$$$$  /$$   /$$'
printf "\n"
printf "${PURPLE_2_FG}"
printf '| $$  / $$| $$_____/| $$__  $$|_  $$_/ /$$__  $$| $$$ | $$'
printf "\n"
printf "${PURPLE_3_FG}"
printf '|  $$/ $$/| $$      | $$  \ $$  | $$  | $$  \ $$| $$$$| $$'
printf "\n"
printf "${PURPLE_4_FG}"
printf ' \  $$$$/ | $$$$$   | $$$$$$$   | $$  | $$$$$$$$| $$ $$ $$'
printf "\n"
printf "${PURPLE_5_FG}"
printf '  >$$  $$ | $$__/   | $$__  $$  | $$  | $$__  $$| $$  $$$$'
printf "\n"
printf "${PURPLE_6_FG}"
printf ' /$$/\  $$| $$      | $$  \ $$  | $$  | $$  | $$| $$\  $$$'
printf "\n"
printf "${PURPLE_7_FG}"
printf '| $$  \ $$| $$$$$$$$| $$$$$$$/ /$$$$$$| $$  | $$| $$ \  $$'
printf "\n"
printf "${PURPLE_8_FG}"
printf '|__/  |__/|________/|_______/ |______/|__/  |__/|__/  \__/'
printf "${RESET}\n\n"

if [ -f /etc/debian_version ]; then
  printf "${GREEN_01_FG}Determined OS Type: Debian${RESET}\n"
else
  printf "${GREEN_01_FG}OS is NOT compatible.${RESET}\n"
fi

if [ -n "$DE_NAME" ]; then
  printf "${GREEN_01_FG}"
  printf "Determined Desktop Environment: $DE_NAME${RESET}\n"
else
  printf "${GREEN_01_FG}"
  printf "Could not determine desktop environment using XDG${RESET}\n"
fi

if [[ "$DE_NAME" == *"GNOME"* ]]; then
  printf "${GREEN_01_FG}Setting up for GNOME...${RESET}\n"
  mkdir -p "$HOME/.xebian"
  cd "$HOME/.xebian"
  sudo apt install gnome-shell-extensions gnome-tweaks git -y >/dev/null 2>&1
  git clone https://github.com/X-REVISION-2/xebian-for-debian.git >/dev/null 2>&1
  cd xebian-for-debian/gnome
  tar -xJvf icons.tar.xz >/dev/null 2>&1
  tar -xJvf theme.tar.xz >/dev/null 2>&1
  mkdir -p "$HOME/.themes"
  mkdir -p "$HOME/.icons"
  mv candy-icons/ "$HOME/.icons/"
  mv Cyberpunk_Neon/ "$HOME/.themes/"
  gsettings set org.gnome.desktop.interface gtk-theme "Xebian-Theme"
  gsettings set org.gnome.desktop.interface icon-theme "Xebian-Icons"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  mkdir -p "$HOME/.wallpapers"
  mv wallpaper.jpg "$HOME/.wallpapers/xebian.jpg"
  gsettings set org.gnome.desktop.background picture-uri-dark "file:///${HOME}/.wallpapers/xebian.jpg"
  printf "${GREEN_01_FG}Xebian theme and icons applied successfully!${RESET}\n"
else
  printf "${GREEN_01_FG}Desktop environment not supported for automatic setup.${RESET}\n"
fi

if [[ "$DE_NAME" == *"KDE"* || "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
  printf "${GREEN_01_FG}Setting up for KDE Plasma with Kvantum...${RESET}\n"

  mkdir -p "$HOME/.xebian"
  cd "$HOME/.xebian" || exit 1

  sudo apt install -y \
    git \
    kvantum \
    qt5-style-kvantum \
    qt5-style-kvantum-themes \
    kde-config-gtk-style \
    unzip >/dev/null 2>&1

  git clone https://github.com/X-REVISION-2/xebian-for-debian.git >/dev/null 2>&1
  cd xebian-for-debian/kde || exit 1

  # Create required KDE directories
  mkdir -p "$HOME/.config/Kvantum"
  mkdir -p "$HOME/.local/share/icons"

  # -----------------------
  # Kvantum Theme
  # -----------------------
  unzip CyberHack.zip >/dev/null 2>&1
  mv CyberHack "$HOME/.config/Kvantum/"

  kvantumkvconfig set Kvantum theme CyberHack
  kvantumkvconfig set General theme CyberHack

  # Set Qt apps to use Kvantum
  kwriteconfig5 --file kdeglobals --group General --key widgetStyle Kvantum

  # -----------------------
  # Cursor Theme
  # -----------------------
  unzip breeze_green.zip >/dev/null 2>&1
  mv breeze_green "$HOME/.local/share/icons/Breeze_Green"

  kwriteconfig5 --file kcminputrc --group Mouse --key cursorTheme "Breeze_Green"

  # -----------------------
  # Icon Pack
  # -----------------------
  tar -xvf Sours-Full-Color.tar.gz >/dev/null 2>&1
  mv Sours-Full-Color "$HOME/.local/share/icons/"

  kwriteconfig5 --file kdeglobals --group Icons --key Theme "Sours-Full-Color"

  # -----------------------
  # Reload Plasma
  # -----------------------
  qdbus org.kde.KWin /KWin reconfigure >/dev/null 2>&1
  qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.refreshCurrentShell >/dev/null 2>&1

  printf "${GREEN_01_FG}Kvantum theme, icons, and cursors applied successfully!${RESET}\n"
else
  printf "${GREEN_01_FG}Desktop environment not supported for automatic setup.${RESET}\n"
fi


### ===============================
### Dialog + package installation
### ===============================
sudo apt install dialog -y >/dev/null 2>&1

HEIGHT=15
WIDTH=60
LIST_HEIGHT=6

choices=$(dialog --separate-output --checklist "Choose options:" \
  $HEIGHT $WIDTH $LIST_HEIGHT \
  1 "OSINT: A suite of utilities for open source intelligence" off \
  2 "RTL-SDR: Programs to manage RTL-SDR devices" off \
  3 "Wireless: Air*-ng, wireshark..." off \
  4 "Blue-team: Blue team tools" off \
  5 "Red-team: Red team tools" off \
  6 "Kali Linux: Install Kali Linux default tools" off \
  2>&1 >/dev/tty)

clear
printf "${PURPLE_1_FG}" 
printf ' /$$   /$$ /$$$$$$$$ /$$$$$$$  /$$$$$$  /$$$$$$  /$$   /$$'
printf "\n"
printf "${PURPLE_2_FG}"
printf '| $$  / $$| $$_____/| $$__  $$|_  $$_/ /$$__  $$| $$$ | $$'
printf "\n"
printf "${PURPLE_3_FG}"
printf '|  $$/ $$/| $$      | $$  \ $$  | $$  | $$  \ $$| $$$$| $$'
printf "\n"
printf "${PURPLE_4_FG}"
printf ' \  $$$$/ | $$$$$   | $$$$$$$   | $$  | $$$$$$$$| $$ $$ $$'
printf "\n"
printf "${PURPLE_5_FG}"
printf '  >$$  $$ | $$__/   | $$__  $$  | $$  | $$__  $$| $$  $$$$'
printf "\n"
printf "${PURPLE_6_FG}"
printf ' /$$/\  $$| $$      | $$  \ $$  | $$  | $$  | $$| $$\  $$$'
printf "\n"
printf "${PURPLE_7_FG}"
printf '| $$  \ $$| $$$$$$$$| $$$$$$$/ /$$$$$$| $$  | $$| $$ \  $$'
printf "\n"
printf "${PURPLE_8_FG}"
printf '|__/  |__/|________/|_______/ |______/|__/  |__/|__/  \__/'
printf "${RESET}\n\n"

### ===============================
### Install functions
### ===============================

sudo apt install curl gnupg -y
if [ ! -f /usr/share/keyrings/kali-keyring.gpg ]; then
  sudo install -d -m 0755 /usr/share/keyrings
  curl -fsSL https://archive.kali.org/archive-key.asc \
    | sudo gpg --dearmor -o /usr/share/keyrings/kali-keyring.gpg
fi

if [ ! -f /etc/apt/sources.list.d/kali.list ]; then
  echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/kali-keyring.gpg] https://http.kali.org/kali kali-rolling main non-free non-free-firmware contrib' \
    | sudo tee /etc/apt/sources.list.d/kali.list
fi
sudo apt update -y

install_osint() {
  printf "${GREEN_01_FG}Installing OSINT tools...${RESET}\n"
  sudo apt install -y \
    amass \
    theharvester \
    recon-ng \
    whois \
    chromium
  wget -o https://raw.githubusercontent.com/X-REVISION-2/osint/refs/heads/main/dist/install.sh -O /tmp/osint_install.sh >/dev/null 2>&1
  chmod +x /tmp/osint_install.sh
  wget -o https://github.com/X-REVISION-2/osint/raw/refs/heads/main/dist/uhc-osint -O /tmp/uhc-osint >/dev/null 2>&1
  chmod +x /tmp/uhc-osint
  /tmp/osint_install.sh >/dev/null 2>&1
  rm -f /tmp/osint_install.sh
  rm -f /tmp/uhc-osint
  sudo apt install kali-linux-forensic -y
}

install_rtlsdr() {
  printf "${GREEN_01_FG}Installing RTL-SDR tools...${RESET}\n"
  sudo apt install -y \
    rtl-sdr \
    gqrx-sdr \
    dump1090-fa \
    sdrsharp
  sudo apt install kali-linux-wireless -y
}

install_wireless() {
  printf "${GREEN_01_FG}Installing wireless tools...${RESET}\n"
  sudo apt install -y \
    aircrack-ng \
    wireshark \
    reaver \
    nmap \
    kismet \
    wifite \
    hping3 \
    netcat \
    tcpdump \
    netexec \
    dnschef \
    wifipumpkin3 \
    airgeddon
  sudo apt install kali-linux-wireless -y
}

install_blue_team() {
  printf "${GREEN_01_FG}Installing blue-team tools...${RESET}\n"
  sudo apt install -y \
    suricata \
    zeek \
    osquery
}

install_red_team() {
  printf "${GREEN_01_FG}Installing red-team tools...${RESET}\n"
  sudo apt install -y \
    nmap \
    metasploit-framework \
    hydra \
    sqlmap \
    john \
    beef-xss \
    nikto \
    responder \
    medusa \
    hashcat \
    wfuzz \
    websploit
  sudo apt install kali-linux-top10 -y
  sudo apt install kali-linux-gpu -y
}

install_kali() {
  printf "${GREEN_01_FG}Installing Kali Linux tools...${RESET}\n"
  sudo apt install -y kali-linux-default
  eval "$(wget -O- https://get.x-cmd.com)"
}

### ===============================
### Handle selections
### ===============================
for choice in $choices; do
  case $choice in
    1) install_osint ;;
    2) install_rtlsdr ;;
    3) install_wireless ;;
    4) install_blue_team ;;
    5) install_red_team ;;
    6) install_kali ;;
  esac
done

printf "${GREEN_01_FG}All selected components installed.${RESET}\n"
printf "${GREEN_01_FG}Installation complete!${RESET}\n"
sleep 2
sudo reboot -f