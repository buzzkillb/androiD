#!/bin/bash

echo "Updating linux packages"
apt-get update -y && apt-get upgrade -y

apt-get --assume-yes install git unzip build-essential libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libevent-dev autogen automake  libtool libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools

apt-get --assume-yes install qt5-default

echo "Downgrade libssl-dev"
apt-get install make
wget https://www.openssl.org/source/openssl-1.0.1j.tar.gz
tar -xzvf openssl-1.0.1j.tar.gz
cd openssl-1.0.1j
./config
make install
ln -sf /usr/local/ssl/bin/openssl `which openssl`
cd ~
openssl version -v

echo "Installing Denarius Wallet"
git clone https://github.com/carsenk/denarius
cd denarius
git checkout v3.4
git pull

#echo "Change line in denarius-qt.pro from stdlib=c99 to stdlib=gnu99"
#sed -i 's/c99/gnu99/' ~/denarius/denarius-qt.pro

qmake "USE_UPNP=1" "USE_QRCODE=1" OPENSSL_INCLUDE_PATH=/usr/local/ssl/include OPENSSL_LIB_PATH=/usr/local/ssl/lib denarius-qt.pro
make

echo "Populate denarius.conf"
mkdir ~/.denarius
echo -e "nativetor=1\naddnode=denarius.host\naddnode=denarius.win\naddnode=denarius.pro\naddnode=triforce.black" > ~/.denarius/denarius.conf

#echo "Get Chaindata"
#cd ~/.denarius
#rm -rf database txleveldb smsgDB
#wget https://github.com/carsenk/denarius/releases/download/v3.3.6/chaindata1612994.zip
#unzip chaindata1612994.zip
