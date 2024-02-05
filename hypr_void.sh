# Create a place to put our void-src packages
mkdir -p $HOME/.local/{pkgs,fonts}
cd $HOME/.local/pkgs

# Install applications and binaries
sudo xbps-install \
git \
xorg-fonts \
vim \
kitty \
seatd \
dbus \
mesa-dri \
neofetch \
-y

# Clone void-packages git repo
git clone https://github.com/void-linux/void-packages.git

# Clone hyprland-void git repo
git clone https://github.com/Makrennel/hyprland-void.git

# Navigate to the void-packages folder
cd $HOME/.local/pkgs/void-packages/
./xbps-src binary-bootstrap

# Navigate to the hyprland-void packages folder
cd $HOME/.local/pkgs/hyprland-void/
cat common/shlibs >> $HOME/.local/pkgs/void-packages/common/shlibs
cp -r srcpkgs/* $HOME/.local/pkgs/void-packages/srcpkgs
cd $HOME/.local/pkgs/void-packages/
./xbps-src pkg hyprland
./xbps-src pkg xdg-desktop-portal-hyprland
./xbps-src pkg hyprland-protocols

sudo xbps-install -R hostdir/binpkgs hyprland -y
sudo xbps-install -R hostdir/binpkgs hyprland-protocols -y
sudo xbps-install -R hostdir/binpkgs xdg-desktop-portal-hyprland -y

sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/polkitd /var/service
sudo ln -s /etc/sv/seatd /var/service

sudo usermod -aG _seatd $SUDO_USER

echo "neofetch" >> $HOME/.bashrc

sudo reboot