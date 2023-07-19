# 书虫兼容环境
书虫兼容环境，使用bwrap容器在deepin或UOS上使用Debian 12的应用，为你带来更好的使用体验！

兼容环境内不允许提权，若要在容器内使用root，请使用 sudo /opt/apps/store.spark-app.bookworm-compatibility-mode/files/bin/bookworm-run

## 构建指南

先构建容器再打包，容器位置在`src/opt/apps/store.spark-app.bookworm-compatibility-mode/files/`


# Bookworm compatibility mode

Bookworm compatibility mode allows you to use Debian 12 applications on deepin or UniontechOS using bwrap containers, providing you with a better user experience!

It is not allowed to gain root privileges within the compatible environment. If you need to use root within the container, please use "sudo /opt/apps/store.spark-app.bookworm-compatibility-mode/files/bin/bookworm-run"

## Build Guide

Build the container first then build the package. Container at `src/opt/apps/store.spark-app.bookworm-compatibility-mode/files/` 
