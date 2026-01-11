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

mkdir -p "$HOME/.xebian"
cd "$HOME/.xebian"

if [[ "$DE_NAME" == *"GNOME"* ]]; then
  printf "${GREEN_01_FG}Setting up for GNOME...${RESET}\n"
  sudo apt install gnome-shell-extensions gnome-tweaks -y >/dev/null 2>&1
  git clone https://github.com/X-REVISION-2/xebian-for-debian.git >/dev/null 2>&1
  cd xebian-for-debian/gnome
  tar -xJvf icons.tar.xz >/dev/null 2>&1
  tar -xJvf theme.tar.xz >/dev/null 2>&1
  mkdir -p "$HOME/.themes"
  mkdir -p "$HOME/.icons"
  mv icons "$HOME/.icons/Xebian-Icons"
  mv theme "$HOME/.themes/Xebian-Theme"
  gsettings set org.gnome.desktop.interface gtk-theme "Xebian-Theme"
  gsettings set org.gnome.desktop.interface icon-theme "Xebian-Icons"
  printf "${GREEN_01_FG}Xebian theme and icons applied successfully!${RESET}\n"
else
  printf "${GREEN_01_FG}Desktop environment not supported for automatic setup.${RESET}\n"
fi