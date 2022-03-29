# Made by Ansh Dadwal
echo "Installing Packages"
apt update 
apt install x11-repo -y
apt install neovim fish neofetch -y 
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Installing Configrations"
mkdir ~/.config > /dev/null 2>&1
rm -rf  ~/.config && mv .config ~/.config
chsh -s fish
echo "Installed Success"
