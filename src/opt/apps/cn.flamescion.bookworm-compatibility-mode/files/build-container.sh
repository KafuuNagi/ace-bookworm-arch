#!/bin/bash
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
sudo debootstrap --arch=${ARCH} bookworm ./bookworm-env https://mirrors.ustc.edu.cn/debian/

pushd bookworm-env


gitee_api_url="https://gitee.com/api/v5/repos/amber-compatability-environment/ace-host-integration/releases/latest"
resp="$(curl -s $gitee_api_url)"
VERSION_GITEE="$(jq -r '.tag_name' <<<$resp | sed "s/.*V\([^_]*\).*/\1/g")"
echo "$VERSION_GITEE"

sudo wget https://gitee.com/amber-compatability-environment/ace-host-integration/releases/download/0.1/ace-host-integration_${VERSION_GITEE}_all.deb

popd

sudo systemd-nspawn -D bookworm-env apt install /ace-host-integration_${VERSION_GITEE}_all.deb -y
sudo rm bookworm-env/ace-host-integration_${VERSION_GITEE}_all.deb


sudo rm -rf bookworm-env/var/cache/apt/archives/*.deb

sudo tar -I 'xz -T0' -cvf bookworm-env.tar.xz bookworm-env/*
sudo rm -rf bookworm-env
