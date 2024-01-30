# 书虫兼容模式
书虫兼容模式，是`琥珀兼容环境(ACE)`的一部分




# Bookworm compatibility mode

Bookworm compatibility mode is a part of `Amber Compatability Environment(ACE)`

Amber Compatability Environment is a container app packaging and distributing solution.

With the help of bubblewrap, a super tiny container solution, you can run a `Debian 12` container in almost every linux distrobution. When you can not launch or pack an `Appimage` App, using Bookworm compatibility mode can allow you to pack the app in a newer environment and also be able to run on more distrobutions. It is a good choice! 

Bookworm compatibility mode allows you to use Debian 12 applications on deepin or UniontechOS using bwrap containers, providing you with a better user experience!

Please use `git clone --recurse-submodules` to obtain the env


## Install Guide


### Quick Install (Debian)

https://bbs.spark-app.store/d/1668-xing-huo-ying-yong-shang-dian-on-ace

### Manual Install（Debian/Fedora/Arch)

http://core.shenmo.tech:38324/index.php?share/folder&user=1&sid=kr8z6Fqf

## Build Guide

### Debian

Build the container first then build the package. Container at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`
Here are the details:
1. Install dependencies: sudo apt-get install arch-test debootstrap libnss-mymachines systemd-container
2. Enter the terminal at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files` and execute `./build-container.sh amd64`.[for amd,other arch please change]
3. Wait for the container to complete.
4.Get in to `bookworm-compatibility-mode` dir,run`fakeroot dpkg-deb -b src .`
5.Wating for complete.


### Fedora

See https://gitee.com/amber-compatability-environment/ace-rpm

### Arch

`yay -S cn.flamescion.bookworm-compatibility-mode`
