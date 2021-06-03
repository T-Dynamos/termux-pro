EOF
}
install_deb() {
  LIST_FILE=/etc/apt/sources.list.d/metasploit-framework.list
  PREF_FILE=/etc/apt/preferences.d/pin-metasploit.pref
  echo -n "Adding metasploit-framework to your repository list.."
  echo "deb $DOWNLOAD_URI/apt lucid main" > $LIST_FILE
  print_pgp_key | apt-key add -
  if [ ! -f $PREF_FILE ]; then
    mkdir -p /etc/apt/preferences.d/
    cat > $PREF_FILE <<EOF
Package: metasploit*
Pin: origin downloads.metasploit.com
Pin-Priority: 1000
EOF
  fi
  echo -n "Updating package cache.."
  apt-get update > /dev/null
  echo "OK"
  echo "Checking for and installing update.."
  apt-get install -y --allow-downgrades metasploit-framework
}

install_rpm() {
  echo "Checking for and installing update.."
  REPO_FILE=/etc/yum.repos.d/metasploit-framework.repo
  GPG_KEY_FILE=/etc/pki/rpm-gpg/RPM-GPG-KEY-Metasploit
  echo -n "Adding metasploit-framework to your repository list.."

  cat > /etc/yum.repos.d/metasploit-framework.repo <<EOF
[metasploit]
name=Metasploit
baseurl=$DOWNLOAD_URI/rpm
gpgcheck=1
gpgkey=file://$GPG_KEY_FILE
enabled=1
EOF
  print_pgp_key > ${GPG_KEY_FILE}
  yum install -y metasploit-framework
}

install_suse() {
  echo "Checking for and installing update.."
  GPG_KEY_FILE_DIR=/etc/pki/rpm-gpg
  GPG_KEY_FILE=${GPG_KEY_FILE_DIR}/RPM-GPG-KEY-Metasploit
  echo -n "Adding metasploit-framework to your repository list.."
  if [ ! -d $GPG_KEY_FILE_DIR ]; then
    mkdir -p $GPG_KEY_FILE_DIR
  fi
  zypper ar  -f $DOWNLOAD_URI/rpm metasploit
  print_pgp_key > ${GPG_KEY_FILE}
  rpmkeys --import ${GPG_KEY_FILE}
  zypper install -y metasploit-framework
}

install_pkg()
{
  (
    cd ~/Downloads

    echo "Downloading package..."
    curl -O "$DOWNLOAD_URI/osx/metasploitframework-latest.pkg"

    echo "Checking signature..."

    if pkgutil --check-signature metasploitframework-latest.pkg; then
      echo "Installing package..."
      installer -pkg metasploitframework-latest.pkg -target /
    fi

    echo "Cleaning up..."
    rm -fv metasploitframework-latest.pkg
  )
}

DOWNLOAD_URI=http://downloads.metasploit.com/data/releases/metasploit-framework
PKGTYPE=unknown
ID=`id -u`

if [ -f /etc/redhat-release ] ; then
  PKGTYPE=rpm
elif [ -f /etc/system-release ] ; then
  # If /etc/system-release is present, this is likely a distro that uses RPM.
  PKGTYPE=rpm
else
  if uname -sv | grep 'Darwin' > /dev/null; then
    PKGTYPE=pkg
  elif [ -f /usr/bin/zypper ] ; then
    PKGTYPE=sus
  else
    PKGTYPE=deb

case $PKGTYPE in
  deb)
    install_deb
    ;;
  sus)
    install_suse
    ;;
  rpm)
    install_rpm
    ;;
  *)
    install_pkg
esac
