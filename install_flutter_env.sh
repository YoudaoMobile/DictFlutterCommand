#!/bin/sh
brew install wget
mkdir ~/development
cd ~/development
wget https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.9.1+hotfix.6-stable.zip
unzip ./flutter_macos_v1.9.1+hotfix.6-stable


sudo -s touch /etc/paths.d/flutter
sudo chmod 777 /etc/paths.d/flutter
sudo -s echo "`pwd`/flutter/bin" > /etc/paths.d/flutter

sudo -s touch /etc/paths.d/dart
sudo chmod 777 /etc/paths.d/dart
sudo -s echo "`pwd`/flutter/bin/cache/dart-sdk/bin" > /etc/paths.d/dart

source /etc/paths
export PATH=$PATH:`pwd`/flutter/bin
flutter doctor
read -s -n1 -p "按任意键继续 ... "
