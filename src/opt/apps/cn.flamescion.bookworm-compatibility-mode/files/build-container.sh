#!/bin/bash
if [ `which debootstrap` = "" ];then
echo "Need to install debootstrap!"
exit
fi

cd "`dirname $0`"
sudo debootstrap bookworm ./bookworm-env https://mirrors.ustc.edu.cn/debian/
tar -I 'xz -T0' -cvf bookworm-env.tar.xz bookworm-env/*
sudo rm -rf bookworm-env
