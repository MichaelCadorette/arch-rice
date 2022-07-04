#!/bin/sh

#check for root
[ "$(id -u)" = 0 ] && echo "This script MUST NOT be run as root as it makes changes to the users home directory." && exit 1

echo "###############################"
echo "#    UPDATING REPOSITORIES    #"
echo "###############################"
sudo pacman -Sy

echo "#################################"
echo "#    INSTALLING DEPENDENCIES    #"
echo "#################################"
sudo pacman -S --noconfirm --needed git base-devel xorg xorg-xinit vim ttf-font-awesome noto-fonts picom lxsession feh xautolock

#create arch-rice install directory
[[ -f ~/.rice_install ]] || mkdir ~/.rice_install

#move dwm config files into their appropriate directories
[[ -f ~/.dwm ]] || mkdir ~/.dwm
chmod +x autostart.sh ; cp autostart.sh ~/.dwm
chmod +x dwmbar.sh ; cp dwmbar.sh ~/.dwm
cp wallpaper.jpg ~/.dwm
sudo [[ -f /usr/share/xsessions ]] || mkdir /usr/share/xsessions
sudo cp dwm.desktop /usr/share/xsessions

#will exec startx automatically if in tty1
echo "############################"
echo "#    CONFIGURING BASHRC    #"
echo "############################"
cat .bashrc > ~/.bashrc


#install pfetch (simpler neofetch)
echo "###########################"
echo "#    INSTALLING PFETCH    #"
echo "###########################"
cd ~/.rice_install
git clone https://aur.archlinux.org/pfetch.git
cd pfetch
makepkg -si --noconfirm

#install dwm
echo "########################"
echo "#    INSTALLING DWM    #"
echo "########################"
cd ~/.rice_install
git clone https://github.com/MichaelCadorette/dwm
cd dwm
sudo make clean install

#configuring xinitrc to start dwm
echo "#############################"
echo "#    CONFIGURING XINITRC    #"
echo "#############################"
echo "exec dwm" > ~/.xinitrc

#install st
echo "#######################"
echo "#    INSTALLING ST    #"
echo "#######################"
cd ~/.rice_install
git clone https://github.com/MichaelCadorette/st
cd st
sudo make clean install

#install dmenu
echo "##########################"
echo "#    INSTALLING DMENU    #"
echo "##########################"
cd ~/.rice_install
git clone https://github.com/MichaelCadorette/dmenu
cd dmenu
sudo make clean install

#install slock (simple x locker)
echo "##########################"
echo "#    INSTALLING SLOCK    #"
echo "##########################"
cd ~/.rice_install
git clone https://github.com/MichaelCadorette/slock
cd slock
sudo make clean install

echo "###################"
echo "#    REBOOTING    #"
echo "###################"
sudo reboot
