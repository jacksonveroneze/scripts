# -----------------------------------------------------------------------
# Update System
# -----------------------------------------------------------------------
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && \
  sudo apt clean && sudo apt autoclean && sudo apt autoremove -y && \
  sudo rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------
# Install Packages
# -----------------------------------------------------------------------
sudo apt install -y --no-install-recommends \
  ubuntu-restricted-extras gparted gnome-tweaks \
  git tilix fzf unrar curl apt-transport-https ca-certificates \
  software-properties-common net-tools htop usb-creator-gtk p7zip -y

sudo snap install firefox vlc spotify postman insomnia dbeaver-ce
sudo snap install code --classic
sudo snap install sublime-text --classic
sudo snap install rider --classic

# -----------------------------------------------------------------------
# Install Chrome
# -----------------------------------------------------------------------
wget -c "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo dpkg -i google-chrome-stable_current_amd64.deb

# -----------------------------------------------------------------------
# Install .NET
# -----------------------------------------------------------------------
apt install dotnet-sdk-7.0 -y 

# -----------------------------------------------------------------------
# Install Docker
# -----------------------------------------------------------------------
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update; sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

# -----------------------------------------------------------------------
# Install Docker compose
# -----------------------------------------------------------------------
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

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
# Install Wireshark
# -----------------------------------------------------------------------
yes | sudo DEBIAN_FRONTEND=noninteractive apt install wireshark
sudo usermod -aG wireshark $USER

# -----------------------------------------------------------------------
# Others
# -----------------------------------------------------------------------
mkdir -p ${HOME}/workspace
sudo -u $USER bash -c "ssh-keygen -f /home/$USER/.ssh/id_rsa -N ''"

git config --global user.email "jackson@jacksonveroneze.com"
git config --global user.name "Jackson Veroneze"
