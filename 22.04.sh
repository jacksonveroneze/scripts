# -----------------------------------------------------------------------
# Update System
# -----------------------------------------------------------------------
sudo apt update; sudo apt dist-upgrade -y; sudo apt autoremove -y

# -----------------------------------------------------------------------
# Install Packages
# -----------------------------------------------------------------------
sudo apt install ubuntu-restricted-extras -y
sudo apt install gparted gnome-tweaks tilix fzf git unrar curl apt-transport-https ca-certificates software-properties-common htop usb-creator-gtk p7zip -y
sudo snap install vlc spotify postman insomnia dbeaver-ce
sudo snap install code --classic
sudo snap install sublime-text --classic
sudo snap install rider --classic

# -----------------------------------------------------------------------
# Install .NET 6.0
# -----------------------------------------------------------------------
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt update; apt install dotnet-sdk-6.0 -y 

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
# Others
# -----------------------------------------------------------------------
mkdir -p ${HOME}/workspace
sudo -u $USER bash -c "ssh-keygen -f /home/$USER/.ssh/id_rsa -N ''"


git config --global user.email "jackson@jacksonveroneze.com"
git config --global user.name "Jackson Veroneze"
