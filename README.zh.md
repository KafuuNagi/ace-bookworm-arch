# ACE Debian Bookworm

# [English](README.md)


琥珀兼容环境是一款基于bubblewrap的容器化应用打包和分发方案。

书虫兼容模式用极为轻量的容器方案让你可以在几乎任何的Linux发行版上运行一个`Debian 12`容器。在`Appimage`应用无法启动或者打包的时候，使用书虫兼容模式来打包可以让你在使用最新的环境的同时在更多的发行版上运行，是一个很好的选择

 **首次安装后请注销或重启以展示启动器入口** 

请使用 `git clone --recurse-submodules` 来获取

## 安装指南

### 快捷安装 (需要安装星火应用商店)

[spk://store/tools/cn.flamescion.bookworm-compatibility-mode/](https://spk-resolv.spark-app.store/?spk=spk://store/tools/cn.flamescion.bookworm-compatibility-mode/)

### 手动安装（Debian/Fedora/Arch)


分享链接：https://pan.huang1111.cn/s/jR1GdUy

Ubuntu 18.04 需要安装 https://packages.debian.org/buster/bubblewrap 

Arch：`yay -S amber-ce-bookworm`

---


## 构建指南

### Debian

```
apt build-dep .
dpkg-buildpackage -us -uc -b 
```

### Fedora

请前往 https://gitee.com/amber-ce/ace-rpm

### Arch

`yay -S amber-ce-bookworm`

---