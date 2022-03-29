# Made by Ansh Dadwal
print_logo () {
	clear
	echo -e "\e[1;36m
╔════╗               ╔═══╗
║╔╗╔╗║               ║╔═╗║
╚╝║║╠╩═╦═╦╗╔╦╗╔╦╗╔╗  ║╚═╝╠═╦══╗
  ║║║║═╣╔╣╚╝║║║╠╬╬╝  ║╔══╣╔╣╔╗║
  ║║║║═╣║║║║║╚╝╠╬╬╗  ║║  ║║║╚╝║
  ╚╝╚══╩╝╚╩╩╩══╩╝╚╝  ╚╝  ╚╝╚══╝
	By Ansh Dadwal 
\e[0m"
}

install_termuxpro () {
	print_logo
	echo -e "\e[1;43mInstalling Packages\e[0m"
	echo ""
	apt update 
	apt install x11-repo -y
	apt install neovim fish neofetch -y 
	curl  https://git.io/fisher > t.txt && fish t.txt && fisher install jorgebucaran/fisher && rm t.txt
	fisher install IlanCosman/tide@v5
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	echo ""
	echo -e "\e[1;43mInstalling Configrations\e[0m"
	echo ""
	rm -rf $PREFIX/tmp/termux-pro > /dev/null  2>&1
	git clone https://github.com/T-Dynamos/termux-pro $PREFIX/tmp/termux-pro
	cd $PREFIX/tmp/termux-pro
	mkdir ~/.config > /dev/null 2>&1
	rm -rf  ~/.config && cp -r .config ~/.config
	chsh -s fish
	rm $PREFIX/etc/motd > /dev/null 2>&1
	echo ""
	echo -e "\e[1;42mInstalled Success and now you can change font with termun-styling and restart termux\e[1;31m"  
	exit 0
}

uninstall_termuxpro () {
	print_logo
	echo -e "\e[1;31mUnisntalling Termux-Pro\e[0m"
	echo ""
	apt remove fish neovim neofetch -y
	rm -rf ~/.config
	apt install wget -y
	wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/motd -O $PREFIX/etc/motd
	chsh -s bash
	echo -e "\e[1;31mUninstall Success , Now restart termux\e[0m"
	exit 0
}
print_help () {
	print_logo
	echo -e "./install.sh install   [for install]"
	echo -e "./install.sh uninstall [for unsinatll]"
	exit 0
}
if [ $1 == "install" ]
then
	install_termuxpro
elif [ $1 == "uninstall" ]
then
	uninstall_termuxpro
else
	print_help
fi
