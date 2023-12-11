#!/bin/bash
set -e
if [ `which debootstrap` = "" ];then
echo "Need to install debootstrap!"
exit
fi

if [ `which systemd-nspawn` = "" ];then
echo "Need to install systemd-container!"
exit
fi


if [ "$1" = "amd64" ] || [ "$1" = "x64" ];then
ARCH="amd64"
ARCH_ANOTHERWAY="x64"
elif [ "$1" = "arm64" ] || [ "$1" = "arm" ];then
ARCH="arm64"
ARCH_ANOTHERWAY="arm64"
else
echo "Invalid architecture! Exit"
exit 1
fi

cd "`dirname $0`"
sudo debootstrap --include=apt-utils,bash-completion,bc,curl,dialog,diffutils,findutils,gnupg2,less,libnss-myhostname,libvte-common,lsof,ncurses-base,passwd,pinentry-curses,procps,sudo,time,util-linux,wget,libegl1-mesa,libgl1-mesa-glx,libvulkan1,mesa-vulkan-drivers,locales,libglib2.0-bin --arch=${ARCH} bookworm ./bookworm-env https://mirrors.ustc.edu.cn/debian/ 


sudo rm -rf bookworm-env/var/cache/apt/archives/*.deb

sudo tar -I 'xz -T0' -cvf bookworm-env.tar.xz bookworm-env/*
sudo rm -rf bookworm-env

pushd flamescion-container-tools/ace-host-integration

dpkg-deb -Z xz -b . ../ace-host-integration.deb

popd


