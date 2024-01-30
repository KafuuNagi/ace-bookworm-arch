# 书虫兼容模式

琥珀兼容环境是一款基于bubblewrap的容器化应用打包和分发方案。

书虫兼容模式用极为轻量的容器方案让你可以在几乎任何的Linux发行版上运行一个`Debian 12`容器。在`Appimage`应用无法启动或者打包的时候，使用书虫兼容模式来打包可以让你在使用最新的环境的同时在更多的发行版上运行，是一个很好的选择

书虫兼容模式让你可以在deepin或UOS上使用Debian 12的应用，为你带来更好的使用体验！

请使用 `git clone --recurse-submodules` 来获取

## 安装指南

### 快捷安装 (Debian)

https://bbs.spark-app.store/d/1668-xing-huo-ying-yong-shang-dian-on-ace

### 手动安装（Debian/Fedora/Arch)

http://core.shenmo.tech:38324/index.php?share/folder&user=1&sid=kr8z6Fqf

## 构建指南

### Debian

先构建容器再打包，容器位置在`src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`

下面是详细步骤：

1. 安装依赖：sudo apt-get install arch-test debootstrap libnss-mymachines systemd-container
2. 在`src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`位置进入终端，执行`./build-container.sh amd64`[amd架构，其他架构同理]`
3. 等待容器打包完成
4. 进入`bookworm-compatibility-mode`目录，执行`fakeroot dpkg-deb -b src .`
5. 等待打包完成

### Fedora

请前往 https://gitee.com/amber-compatability-environment/ace-rpm

### Arch

`yay -S cn.flamescion.bookworm-compatibility-mode`

---