apt update
apt upgrade -y
apt install wget -y
apt install root-repo
apt install unstable-repo
apt install x11-repo
apt install git -y
apt install python -y
apt install python-pip -y
apt install rust -y
apt install neofetch -y
pip install lolcat
pip install routersploit
cd
git clone https://github.com/Ignitetch/AdvPhishing
git clone https://github.com/T-Dynamos/Maths_Bot m_bot
git clone https://github.com/Cabbagec/termux-ohmyzsh
git clone https://github.com/rajkumardusad/IP-Tracer.git ip
git clone https://github.com/DarkSecDevelopers/HiddenEye-Legacy server
cd /data/data/com.termux/files/usr/bin
wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/mbot
wget https://raw.githubusercontent.com/T-Dynamos/Tvirus2.0/main/hack
wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/exploit
wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/msf
wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/rsf
chmod +x *
cd
"

center() {
  termwidth=$(stty size | cut -d" " -f2)
  padding="$(printf '%0.1s' ={1..500})"
  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

# Loading spinner
center " Loading..."
source <(echo "c3Bpbm5lcj0oICd8JyAnLycgJy0nICdcJyApOwoKY291bnQoKXsKICBzcGluICYKICBwaWQ9JCEKICBmb3IgaSBpbiBgc2VxIDEgMTBgCiAgZG8KICAgIHNsZWVwIDE7CiAgZG9uZQoKICBraWxsICRwaWQgIAp9CgpzcGluKCl7CiAgd2hpbGUgWyAxIF0KICBkbyAKICAgIGZvciBpIGluICR7c3Bpbm5lcltAXX07IAogICAgZG8gCiAgICAgIGVjaG8gLW5lICJcciRpIjsKICAgICAgc2xlZXAgMC4yOwogICAgZG9uZTsKICBkb25lCn0KCmNvdW50" | base64 -d)

echo
center "*** Dependencies installation..."

# Add gushmazuko repository to install ruby 2.7.2 version
echo 'deb https://github.com/gushmazuko/metasploit_in_termux/raw/master gushmazuko main'  | tee $PREFIX/etc/apt/sources.list.d/gushmazuko.list

pkg install -y gnupg
curl -fsSL https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/gushmazuko-gpg.pubkey | gpg --dearmor | tee $PREFIX/etc/apt/trusted.gpg.d/gushmazuko-repo.gpg

# Set low priority for all gushmazuko repository (for security purposes)
# Set highest priority for ruby package from gushmazuko repository
echo '## Set low priority for all gushmazuko repository (for security purposes)
Package: *
Pin: release gushmazuko
Pin-Priority: 100

## Set highest priority for ruby package from gushmazuko repository
Package: ruby
Pin: release gushmazuko
Pin-Priority: 1001' | tee $PREFIX/etc/apt/preferences.d/preferences

# Purge installed ruby
apt purge ruby -y
rm -fr $PREFIX/lib/ruby/gems

pkg upgrade -y -o Dpkg::Options::="--force-confnew"
pkg install -y python autoconf bison clang coreutils curl findutils apr apr-util postgresql openssl readline libffi libgmp libpcap libsqlite libgrpc libtool libxml2 libxslt ncurses make ncurses-utils ncurses git wget unzip zip tar termux-tools termux-elf-cleaner pkg-config git ruby -o Dpkg::Options::="--force-confnew"

python3 -m pip install --upgrade pip
python3 -m pip install requests

echo
center "*** Fix ruby BigDecimal"
source <(curl -sL https://github.com/termux/termux-packages/files/2912002/fix-ruby-bigdecimal.sh.txt)

echo
center "*** Erasing old metasploit folder..."
rm -rf $HOME/metasploit-framework

echo
center "*** Downloading..."
cd $HOME
git clone https://github.com/rapid7/metasploit-framework.git --depth=1

echo
center "*** Installation..."
cd $HOME/metasploit-framework
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec
gem install bundler
sed 's|nokogiri (1.*)|nokogiri (1.8.0)|g' -i Gemfile.lock

gem install nokogiri -v 1.8.0 -- --use-system-libraries

gem install actionpack
bundle update activesupport
bundle update --bundler
bundle install -j$(nproc --all)
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
if [ -e $PREFIX/bin/msfconsole ];then
	rm $PREFIX/bin/msfconsole
fi
if [ -e $PREFIX/bin/msfvenom ];then
	rm $PREFIX/bin/msfvenom
fi
ln -s $HOME/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/
ln -s $HOME/metasploit-framework/msfvenom /data/data/com.termux/files/usr/bin/
termux-elf-cleaner /data/data/com.termux/files/usr/lib/ruby/gems/2.4.0/gems/pg-0.20.0/lib/pg_ext.so

echo
center "*** Database configuration..."
cd $HOME/metasploit-framework/config
curl -sLO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/database.yml

mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql

pg_ctl -D $PREFIX/var/lib/postgresql start
createuser msf
createdb msf_database

cd $HOME
curl -sLO https://raw.githubusercontent.com/gushmazuko/metasploit_in_termux/master/postgresql_ctl.sh
chmod +x postgresql_ctl.sh

echo
center "*"
echo -e "\033[32m Installation complete. \n To start msf database use: ./postgresql_ctl.sh start \n Launch metasploit by executing: msfconsole\033[0m"
center "*"
cd 
apt install ruby -y
gem install lolcat -y 
apt install toilet -y
cd AdvPhishing
rm -rf secnhack
wget https://raw.githubusercontent.com/T-Dynamos/advphishing/main/secnhack
bash Android-Setup.sh
cd
cd ip
chmod +x *
./install
cd
cd termux-ohmyzsh
bash install.sh
cd
chmod +x *
pip install lolcat 
pip install colorama
pip install table-ex
pip install py-loader
pip install requests
cd
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip 
unzip ngrok-stable-linux-arm.zip 
rm ngrok-stable-linux-arm.zip 
apt install toilet -y
clear
cd /data/data/com.termux/files/usr/etc
rm profile
wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/profile
cd $HOME
wget https://raw.githubusercontent.com/T-Dynamos/termux-pro/main/c.py
python c.py
rm c.py
