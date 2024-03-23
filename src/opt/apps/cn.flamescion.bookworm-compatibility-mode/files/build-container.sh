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
cd "`dirname $0`"
sudo debootstrap --include=libnotify-bin,apt-utils,bash-completion,bc,curl,dialog,diffutils,findutils,gnupg2,less,libnss-myhostname,libvte-common,lsof,ncurses-base,passwd,pinentry-curses,procps,sudo,time,util-linux,wget,libegl1-mesa,libgl1-mesa-glx,libvulkan1,mesa-vulkan-drivers,locales,libglib2.0-bin --arch=${ARCH} bookworm ./ace-env https://mirrors.ustc.edu.cn/debian/ 

elif [ "$1" = "arm64" ] || [ "$1" = "arm" ];then
ARCH="arm64"
ARCH_ANOTHERWAY="arm64"

cd "`dirname $0`"
sudo debootstrap --include=libnotify-bin,apt-utils,bash-completion,bc,curl,dialog,diffutils,findutils,gnupg2,less,libnss-myhostname,libvte-common,lsof,ncurses-base,passwd,pinentry-curses,procps,sudo,time,util-linux,wget,libegl1-mesa,libgl1-mesa-glx,libvulkan1,mesa-vulkan-drivers,locales,libglib2.0-bin --arch=${ARCH} bookworm ./ace-env https://mirrors.ustc.edu.cn/debian/ 
elif [ "$1" = "loong" ] || [ "$1" = "loong64" ];then
ARCH="loong64"
ARCH_ANOTHERWAY="loong64"
sudo debootstrap --no-check-gpg --include=libnotify-bin,apt-utils,bash-completion,bc,curl,dialog,diffutils,findutils,gnupg2,less,libnss-myhostname,libvte-common,lsof,ncurses-base,passwd,pinentry-curses,procps,sudo,time,util-linux,wget,libegl1,libgl1-mesa-dri,libvulkan1,mesa-vulkan-drivers,locales,libglib2.0-bin --arch=${ARCH} --variant=buildd sid  ./ace-env http://lauosc.cn:11232/debian
else
echo "Need to point out architecture"
exit
fi


sudo rm -rf ace-env/var/cache/apt/archives/*.deb

sudo tar -I 'xz -T0' -cvf ace-env.tar.xz ace-env/*
sudo rm -rf ace-env

pushd flamescion-container-tools/ace-host-integration

dpkg-deb -Z xz -b . ../ace-host-integration.deb

popd


