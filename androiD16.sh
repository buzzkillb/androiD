echo "Updating linux packages"
apt-get update -y && apt-get upgrade -y

apt-get --assume-yes install git unzip build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libevent-dev autogen automake  libtool libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools

apt-get --assume-yes install qt5-default

echo "Installing Denarius Wallet"
git clone https://github.com/carsenk/denarius
cd denarius || exit
git checkout v3.4
git pull

#echo "Change line in denarius-qt.pro from stdlib=c99 to stdlib=gnu99"
#sed -i 's/c99/gnu99/' ~/denarius/denarius-qt.pro

qmake "USE_QRCODE=1" "USE_UPNP=1" denarius-qt.pro
make
