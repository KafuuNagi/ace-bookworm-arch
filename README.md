


# Bookworm compatibility mode

# [中文](README.zh.md)

Bookworm compatibility mode is a part of `Amber Compatability Environment(ACE)`

Amber Compatability Environment is a container app packaging and distributing solution.

With the help of bubblewrap, a super tiny container solution, you can run a `Debian 12` container in almost every linux distrobution. When you can not launch or pack an `Appimage` App, using Bookworm compatibility mode can allow you to pack the app in a newer environment and also be able to run on more distrobutions. It is a good choice! 

 **You need to logout or reboot your computer to show the entries in launcher app list if it's your first time using ACE.** 

Please use `git clone --recurse-submodules` to obtain the env


## Install Guide


### Quick Install (Need to install Spark Store first)

[spk://store/tools/cn.flamescion.bookworm-compatibility-mode/](https://spark-store-project.gitee.io/spk-resolv/?spk=spk://store/tools/cn.flamescion.bookworm-compatibility-mode/)

### Manual Install（Debian/Fedora/Arch)

https://pan.shenmo.tech/index.php?share/folder&user=1&sid=Ye6kyxQE

(Dependencies are needed to upgrade for Ubuntu 18.04/deepin 15)

https://cdn.d.store.deepinos.org.cn/store/depends/bubblewrap_0.3.1-4_amd64.deb   x86

https://cdn.d.store.deepinos.org.cn/aarch64-store/depends/bubblewrap_0.3.1-4_arm64.deb arm64


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
