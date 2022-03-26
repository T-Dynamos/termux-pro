# Made by Ansh Dadwal
echo "Installing Packages"
apt update 
apt install x11-repo -y
apt install neovim fish neofetch xfce4* tigervnc -y 
echo "Installing Configrations"
mkdir ~/.config > /dev/null 2>&1
rm -rf  ~/.config && mv .config ~/.config
echo "Installed Success"
