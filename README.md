


# Bookworm compatibility mode

# [中文](README.zh.md)

Bookworm compatibility mode is a part of `Amber Compatability Environment(ACE)`

Amber Compatability Environment is a container app packaging and distributing solution.

With the help of bubblewrap, a super tiny container solution, you can run a `Debian 12` container in almost every linux distrobution. When you can not launch or pack an `Appimage` App, using Bookworm compatibility mode can allow you to pack the app in a newer environment and also be able to run on more distrobutions. It is a good choice! 

 **You need to logout or reboot your computer to show the entries in launcher app list if it's your first time using ACE.** 

Please use `git clone --recurse-submodules` to obtain the env


## Install Guide


### Quick Install (Need to install Spark Store first)

[spk://store/tools/cn.flamescion.bookworm-compatibility-mode/](https://spk-resolv.spark-app.store/?spk=spk://store/tools/cn.flamescion.bookworm-compatibility-mode/)

### Manual Install（Debian/Fedora/Arch)

Share Link：https://pan.huang1111.cn/s/jR1GdUy

Ubuntu 18.04 Need install https://packages.debian.org/buster/bubblewrap

Arch: `yay -S amber-ce-bookworm`


### Amber-CE x86

Use LAT to run a x86 bookworm container. Can install x86 debs and run x86 apps 

https://pan.huang1111.cn/s/P63D6Cm


---


## Build Guide

### Debian

Build the container first then build the package. Container at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`
Here are the details:
1. Install dependencies: sudo apt-get install arch-test debootstrap libnss-mymachines systemd-container
2. Enter the terminal at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files` and execute `./build-container.sh amd64`.[for amd,other arch please change]
3. Wait for the container to complete.
4.Get in to `amber-ce-bookworm` dir,run`fakeroot dpkg-deb -b src .`
5.Wating for complete.


### Fedora

See https://gitee.com/amber-ce/ace-rpm

### Arch

`yay -S amber-ce-bookworm`
