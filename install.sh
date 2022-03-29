# Made by Ansh Dadwal

echo -e "\e[1;43mInstalling Packages\e[0m"
echo ""
apt update 
apt install x11-repo -y
apt install neovim fish neofetch -y 
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo ""
echo -e "\e[1;43mInstalling Configrations\e[0m"
echo ""
mkdir ~/.config > /dev/null 2>&1
rm -rf  ~/.config && mv .config ~/.config
chsh -s fish
rm $PREFIX/etc/motd > /dev/null 2>&1
echo ""
echo -e "\e[1;42mInstalled Success and now you can change font with termun-styling and restart termux\e[1;31m"
