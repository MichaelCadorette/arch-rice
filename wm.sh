#!/bin/sh

if [ "$(id -u)" = 0 ]; then
	echo "This script MUST NOT be run as root as it makes changes to the users home directory."
	exit 1
fi

sudo pacman -Sy
sudo pacman -S --noconfirm --needed git base-devel xorg xorg-xinit vim ttf-font-awesome noto-fonts picom lxsession feh xautolock

[[ -f ~/.cdos_install ]] || mkdir ~/.cdos_install

#install pfetch (simpler neofetch)
echo ::Installing pfetch
cd ~/.cdos_install
git clone https://aur.archlinux.org/pfetch.git
cd pfetch
makepkg -si

#install dwm
echo ::Installing dwm
cd ~/.cdos_install
git clone https://github.com/checcdev/dwm
cd dwm
sudo make clean install
[[ -f ~/.dwm ]] || mkdir ~/.dwm
chmod +x autostart.sh ; cp autostart.sh ~/.dwm
chmod +x dwmbar.sh ; cp dwmbar.sh ~/.dwm
cp wallpaper.png ~/.dwm

#install st
echo ::Installing st
cd ~/.cdos_install
git clone https://github.com/checcdev/st
cd st
sudo make clean install

#will exec startx automatically if in tty1
echo ::Configuring bashrc
cat ~/.cdos_install/st/.bashrc > ~/.bashrc

#install dmenu
echo ::Installing dmenu
cd ~/.cdos_install
git clone https://github.com/checcdev/dmenu
cd dmenu 
sudo make clean install

#install slock (simple x locker)
echo ::Installing slock
cd ~/.cdos_install
git clone https://github.com/checcdev/slock
cd slock
sudo make clean install

#startx will start dwm
echo ::Configuring xinitrc to start dwm
echo -e "~/.dwm/autostart.sh &\nexec dwm" > ~/.xinitrc

echo ::Rebooting
sudo reboot
