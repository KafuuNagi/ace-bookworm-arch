Name:       cn.flamescion.bookworm-compatibility-mode
Version:    12.4.7
Release:    1
Summary:    A container app packaging and distributing solution.
License:    unknown
URL:        https://gitee.com/amber-compatability-environment/bookworm-compatibility-mode
Source0:    bookworm-compatibility-mode-%{version}.tar.gz

BuildRequires:  debootstrap, dpkg, bash, which, systemd-container
Requires:       bubblewrap, xdg-desktop-portal, flatpak, zenity, gcc

%description
A container app packaging and distributing solution.

%prep
%autosetup -p1 -n bookworm-compatibility-mode-%{version}
%global debug_package %{nil}

%post
/opt/apps/%{name}/files/bin/bookworm-init

%postun
if [ "$1" = "0" ] || [ "$1" = "1" ]; then
    echo "清理卸载残留"
    rm -rf /opt/apps/%{name}
else
    echo "非卸载，跳过清理"
fi

%install
cp -r src/opt %{buildroot}
cp -r src/etc %{buildroot}
cp -r src/usr %{buildroot}

pushd %{buildroot}/opt/apps/%{name}/files
if [ "%{_target_cpu}" = "aarch64" ]; then
    bash build-container.sh arm64
elif [ "%{_target_cpu}" = "x86_64" ]; then
    bash build-container.sh amd64
else
    echo "Unsupportable arch!"
fi
popd

%files
%dir /opt/apps/%{name}
/opt/apps/%{name}/*
/etc/X11/Xsession.d/20ACE-Bookworm
/etc/profile.d/ACE-Bookworm.sh
%{_bindir}/*
%attr(755,root,root) /usr/lib/systemd/user-environment-generators/60-ACE-Bookworm
%attr(755,root,root) /usr/share/applications/*
/usr/share/icons/*
/usr/share/polkit-1/actions/cn.flamescion.ace-uninstaller.policy

%changelog
* Fri Jan 26 2024 懵仙兔兔 <acgm@qq.com> - 12.4.7-1
  - First pello package
