# 书虫兼容环境
书虫兼容环境，是一款基于bubblewrap的容器化应用打包和分发方案。

用极为轻量的容器方案让你可以在几乎任何的Linux发行版上运行一个`Debian 12`容器。在`Appimage`应用无法启动或者打包的时候，使用书虫兼容环境来打包可以让你在使用最新的环境的同时在更多的发行版上运行，是一个很好的选择

书虫兼容环境让你可以在deepin或UOS上使用Debian 12的应用，为你带来更好的使用体验！

兼容环境内不允许提权，若要在容器内使用root，请使用 sudo bookworm-run

## 构建指南

先构建容器再打包，容器位置在`src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`


# Bookworm compatibility mode

Bookworm compatibility mode is a container app packaging and distributing solution.

With the help of bubblewrap, a super tiny container solution, you can run a `Debian 12` container in almost every linux distrobution. When you can not launch or pack an `Appimage` App, using Bookworm compatibility mode can allow you to pack the app in a newer environment and also be able to run on more distrobutions. It is a good choice! 

Bookworm compatibility mode allows you to use Debian 12 applications on deepin or UniontechOS using bwrap containers, providing you with a better user experience!

It is not allowed to gain root privileges within the compatible environment. If you need to use root within the container, please use "sudo bookworm-run"

## Build Guide

Build the container first then build the package. Container at `src/opt/apps/cn.flamescion.bookworm-compatibility-mode/files`
