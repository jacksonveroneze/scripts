#!/bin/bash

# -----------------------------------------------------------------------
# Update System
# -----------------------------------------------------------------------
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y

# -----------------------------------------------------------------------
# Install Packages
# -----------------------------------------------------------------------
sudo apt install -y --no-install-recommends \
  ubuntu-restricted-extras gparted gnome-tweaks \
  git tilix fzf unrar curl apt-transport-https ca-certificates \
  software-properties-common net-tools htop usb-creator-gtk p7zip \
  apache2-utils postgresql-client mysql-client libfuse2 -y

sudo snap install firefox vlc spotify postman insomnia dbeaver-ce
sudo snap install code --classic
sudo snap install sublime-text --classic
sudo snap install rider --classic
sudo snap install another-redis-desktop-manager dbgate

# -----------------------------------------------------------------------
# Install Chrome
# -----------------------------------------------------------------------
wget -c "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -P /tmp
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# -----------------------------------------------------------------------
# Install Docker
# -----------------------------------------------------------------------
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update; sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

# -----------------------------------------------------------------------
# Install Java
# -----------------------------------------------------------------------
sudo apt install default-jdk -y

# -----------------------------------------------------------------------
# Install zsh
# -----------------------------------------------------------------------
sudo apt install zsh -y
sudo chsh -s /bin/zsh ${USER}
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo apt install fonts-powerline
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)
#configurar tema

# -----------------------------------------------------------------------
# Powerline fonts
# -----------------------------------------------------------------------
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# -----------------------------------------------------------------------
# Install Wireshark
# -----------------------------------------------------------------------
yes | sudo DEBIAN_FRONTEND=noninteractive apt install wireshark
sudo usermod -aG wireshark $USER

# -----------------------------------------------------------------------
# Install Grafana
# -----------------------------------------------------------------------
sudo gpg -k
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install k6

# -----------------------------------------------------------------------
# Clean apt
# -----------------------------------------------------------------------
sudo sudo apt clean && sudo apt autoclean && sudo apt autoremove -y && \
  sudo rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------
# Others
# -----------------------------------------------------------------------
mkdir -p ${HOME}/workspace
sudo -u $USER bash -c "ssh-keygen -f /home/$USER/.ssh/id_rsa -N ''"

git config --global user.email "jacksonvze@gmail.com"
git config --global user.name "Jackson Veroneze"

export GTK_IM_MODULE="ibus"
