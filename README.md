# 书虫兼容模式
书虫兼容模式，是`琥珀兼容环境(ACE)`的一部分

琥珀兼容环境是一款基于bubblewrap的容器化应用打包和分发方案。

书虫兼容模式用极为轻量的容器方案让你可以在几乎任何的Linux发行版上运行一个`Debian 12`容器。在`Appimage`应用无法启动或者打包的时候，使用书虫兼容模式来打包可以让你在使用最新的环境的同时在更多的发行版上运行，是一个很好的选择

书虫兼容模式让你可以在deepin或UOS上使用Debian 12的应用，为你带来更好的使用体验！

请使用 `git clone --recurse-submodules` 来获取

## 构建指南

### Debian

先构建容器再打包，容器位置在`src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`

下面是详细步骤：

1. 安装依赖：sudo apt-get install arch-test debootstrap libnss-mymachines systemd-container
2. 在`src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`位置进入终端，执行`./build-container.sh amd64`[amd架构，其他架构同理]`
3. 等待容器打包完成
4. 进入`bookworm-compatibility-mode`目录，执行fakeroot dpkg-deb -b src cn.flamescion.bookworm-compatibility-mode.deb
5. 等待打包完成

### Fedora

`ACE-rpm`目录下有相关的说明

### Arch

https://bbs.spark-app.store/d/1668-xing-huo-ying-yong-shang-dian-on-ace

# Bookworm compatibility mode

Bookworm compatibility mode is a part of `Amber Compatability Environment(ACE)`

Amber Compatability Environment is a container app packaging and distributing solution.

With the help of bubblewrap, a super tiny container solution, you can run a `Debian 12` container in almost every linux distrobution. When you can not launch or pack an `Appimage` App, using Bookworm compatibility mode can allow you to pack the app in a newer environment and also be able to run on more distrobutions. It is a good choice! 

Bookworm compatibility mode allows you to use Debian 12 applications on deepin or UniontechOS using bwrap containers, providing you with a better user experience!

Please use `git clone --recurse-submodules` to obtain the env

## Build Guide

### Debian

Build the container first then build the package. Container at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`
Here are the details:
1. Install dependencies: sudo apt-get install arch-test debootstrap libnss-mymachines systemd-container
2. Enter the terminal at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files` and execute `./build-container.sh amd64`.[for amd,other arch please change]
3. Wait for the container to complete.
4.Get in to `bookworm-compatibility-mode` dir,run`fakeroot dpkg-deb -b src cn.flamescion.bookworm-compatibility-mode.deb
5.Wating for complete.


### Fedora

See readme in `ACE-rpm` directory

### Arch

https://bbs.spark-app.store/d/1668-xing-huo-ying-yong-shang-dian-on-ace
