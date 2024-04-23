echo "create folders needed"
mkdir -p ~/code
sudo mkdir -p /opt/nvim
sudo mkdir -p /opt/sunshine

echo "generate ssh key pair"
ssh-keygen -t ed25519 -f ~/.ssh/id_rsa -N ""

echo "install basic applicatinos needed"
sudo apt-get update
sudo apt-get install zsh git wget openssh-server curl jq ripgrep yadm build-essential tmux -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing zoxide"
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

echo "Set Git configuration"
git config --global user.email "ryan@drostdev.com"
git config --global user.name "Ryan Drost"
git config --global init.defaultBranch main

echo "clone Yadm configuration repository"
yadm clone git@github.com:Drosty/Dotfiles.git

echo "install zsh plugins - zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "install p10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "install NVIM"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /opt/nvim/nvim

echo "Installing gh CLI Tool"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

echo "Install Node Version Manager"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

echo "Install dotnet SDK's"
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh

echo "Install SDK latest"
./dotnet-install.sh --version latest

echo "Install dotnet SDK 7"
./dotnet-install.sh --version 7.0.408

echo "Install dotnet SDK 6"
./dotnet-install.sh --version 6.0.421

echo "Install Sunshine for Remote Login"
wget https://github.com/LizardByte/Sunshine/releases/download/v0.23.0/sunshine.AppImage
sudo chmod u+x sunshine.AppImage
sudo mv sunshine.AppImage /opt/sunshine/sunshine

rm dotnet-install.sh

echo "******"
echo "Things to do next"
echo "- Install node versions"
echo "  - nvm install stable"
echo "  - nvm install 18"
echo "  - nvm install 16"
echo "  - nvm install 10"
echo "- Install JetBrians Toolbox here: https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux"
echo "- Install Rider with Toolbox"
echo "- run nvim to install all packages"
echo "- run gh auth to authenticate with GitHub"
echo "- run checkout script to get all repositories cloned"
echo "- run /opt/sunshine/sunshie in the terminal"
