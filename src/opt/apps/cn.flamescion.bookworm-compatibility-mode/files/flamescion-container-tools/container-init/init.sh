#!/bin/bash 
if [ "$IS_ACE_ENV" != "1" ];then
echo "ONLY RUN ME IN ACE"
exit
fi



        printf "ACE: Setting up sudo...\n"
        mkdir -p /etc/sudoers.d
        # Do not check fqdn when doing sudo, it will not work anyways
        if ! grep -q 'Defaults !fqdn' /etc/sudoers.d/sudoers; then
                printf "Defaults !fqdn\n" >> /etc/sudoers.d/sudoers
        fi
        # Ensure passwordless sudo is set up for user
        if ! grep -q "\"${container_user_name}\" ALL = (root) NOPASSWD:ALL" /etc/sudoers.d/sudoers; then
                printf "\"%s\" ALL = (root) NOPASSWD:ALL\n" "${container_user_name}" >> /etc/sudoers.d/sudoers
        fi


printf "ACE: Setting up groups...\n"
# If not existing, ensure we have a group for our user.
if ! grep -q "^${container_user_name}:" /etc/group; then
        if ! groupadd --force --gid "${container_user_gid}" "${container_user_name}"; then
                # It may occur that we have users with unsupported user name (eg. on LDAP or AD)
                # So let's try and force the group creation this way.
                printf "%s:x:%s:" "${container_user_name}" "${container_user_gid}" >> /etc/group
        fi
fi

printf "ACE: Setting up users...\n"

# Setup kerberos integration with the host
if [ -d "/run/host/var/kerberos" ] &&
        [ -d "/etc/krb5.conf.d" ] &&
        [ ! -e "/etc/krb5.conf.d/kcm_default_ccache" ]; then

        cat << EOF > "/etc/krb5.conf.d/kcm_default_ccache"
# # To disable the KCM credential cache, comment out the following lines.
[libdefaults]
    default_ccache_name = KCM:
EOF
fi

# If we have sudo/wheel groups, let's add the user to them.
additional_groups=""
if grep -q "^sudo" /etc/group; then
        additional_groups="sudo"
elif grep -q "^wheel" /etc/group; then
        additional_groups="wheel"
fi

# Let's add our user to the container. if the user already exists, enforce properties.
#
# In case of AD or LDAP usernames, it is possible we will have a backslach in the name.
# In that case grep would fail, so we replace the backslash with a point to make the regex work.
# shellcheck disable=SC1003
if ! grep -q "^$(printf '%s' "${container_user_name}" | tr '\\' '.'):" /etc/passwd &&
        ! grep -q "^.*:.*:${container_user_uid}:" /etc/passwd; then
        if ! useradd \
                --home-dir "${container_user_home}" \
                --no-create-home \
                --groups "${additional_groups}" \
                --shell "${SHELL:-"/bin/bash"}" \
                --uid "${container_user_uid}" \
                --gid "${container_user_gid}" \
                "${container_user_name}"; then

                printf "Warning: there was a problem setting up the user\n"
                printf "Warning: trying manual addition\n"
                printf "%s:x:%s:%s:%s:%s:%s" \
                        "${container_user_name}" "${container_user_uid}" \
                        "${container_user_gid}" "${container_user_name}" \
                        "${container_user_home}" "${SHELL:-"/bin/bash"}" >> /etc/passwd
                printf "%s::1::::::" "${container_user_name}" >> /etc/shadow
        fi
# Ensure we're not using the specified SHELL. Run it only once, so that future
# user's preferences are not overwritten at each start.
elif [ ! -e /etc/passwd.done ]; then
        # This situation is presented when podman or docker already creates the user
        # for us inside container. We should modify the user's prepopulated shadowfile
        # entry though as per user's active preferences.

        # If the user was there with a different username, get that username so
        # we can modify it
        if ! grep -q "^$(printf '%s' "${container_user_name}" | tr '\\' '.'):" /etc/passwd; then
                user_to_modify=$(getent passwd "${container_user_uid}" | cut -d: -f1)
        fi

        if ! usermod \
                --home "${container_user_home}" \
                --shell "${SHELL:-"/bin/bash"}" \
                --groups "${additional_groups}" \
                --uid "${container_user_uid}" \
                --gid "${container_user_gid}" \
                --login "${container_user_name}" \
                "${user_to_modify:-"${container_user_name}"}"; then

                printf "Warning: there was a problem setting up the user\n"
        fi
        touch /etc/passwd.done
fi

# We generate a random password to initialize the entry for the user and root.
temporary_password="$(cat /proc/sys/kernel/random/uuid)"
printf "%s\n%s\n" "${temporary_password}" "${temporary_password}" | passwd root
printf "%s:%s" "${container_user_name}" "${temporary_password}" | chpasswd -e
# Delete password for root and user
printf "%s:" "root" | chpasswd -e
printf "%s:" "${container_user_name}" | chpasswd -e

mkdir -p /usr/share/fonts
mkdir -p /usr/share/icons
mkdir -p /usr/share/themes

## init host-spawn
unlink /flamescion-container-tools/bin-override/host-spawn
ln -sfv /flamescion-container-tools/bin-override/host-spawn-$(uname -m) /flamescion-container-tools/bin-override/host-spawn

## install host-integration

apt install --reinstall /flamescion-container-tools/ace-host-integration.deb



### Do NVIDIA Integration

echo "ACE: NVIDIA Integration"

    ensureTargetDir() {
        targetFile=$1
        t=$(dirname "$targetFile")
        mkdir -p "$t"
    }


	lib32_dir="/usr/lib/"
	lib64_dir="/usr/lib/"
	if [ -e "/usr/lib/x86_64-linux-gnu" ]; then
		lib64_dir="/usr/lib/x86_64-linux-gnu/"
	elif [ -e "/usr/lib64" ]; then
		lib64_dir="/usr/lib64/"
	fi
	if [ -e "/usr/lib/i386-linux-gnu" ]; then
		lib32_dir="/usr/lib/i386-linux-gnu/"
	elif [ -e "/usr/lib32" ]; then
		lib32_dir="/usr/lib32/"
	fi

	# First we find all non-lib files we need, this includes
	#	- binaries
	#	- confs
	#	- egl files
	#	- icd files
	#	Excluding here the libs, we will threat them later specifically
	NVIDIA_FILES="$(find /host/etc/ /host/usr/ \
		-path "/host/usr/lib/i386-linux-gnu/*" -prune -o \
		-path "/host/usr/lib/x86_64-linux-gnu/*" -prune -o \
		-path "/host/usr/lib32/*" -prune -o \
		-path "/host/usr/lib64/*" -prune -o \
		-iname "*nvidia*" -not -type d -print 2> /dev/null || :)"
	for nvidia_file in ${NVIDIA_FILES}; do
		dest_file="$(printf "%s" "${nvidia_file}" | sed 's|/host||g')"
		ensureTargetDir ${dest_file}
		cp -r "${nvidia_file}" "${dest_file}" 
	done

	# Then we find all directories with nvidia in the name and just mount them
	NVIDIA_DIRS="$(find /host/etc /host/usr -iname "*nvidia*" -type d 2> /dev/null || :)"
	for nvidia_dir in ${NVIDIA_DIRS}; do
		# /usr/lib64 is common in Arch or RPM based distros, while /usr/lib/x86_64-linux-gnu is
		# common on Debian derivatives, so we need to adapt between the two nomenclatures.
		if printf "%s" "${nvidia_dir}" | grep -Eq "lib32|lib64|x86_64-linux-gnu|i386-linux-gnu"; then

			# Remove origin so we plug our own
			dest_dir="$(printf "%s" "${nvidia_dir}" |
				sed "s|/host/usr/lib/x86_64-linux-gnu/|${lib64_dir}|g" |
				sed "s|/host/usr/lib/i386-linux-gnu/|${lib32_dir}|g" |
				sed "s|/host/usr/lib64/|${lib64_dir}|g" |
				sed "s|/host/usr/lib32/|${lib32_dir}|g")"
		else
			dest_dir="$(printf "%s" "${nvidia_dir}" | sed 's|/host||g')"
		fi
		ensureTargetDir ${dest_file}
		cp -r "${nvidia_dir}" "${dest_file}" 
	done

	# Then we find all the ".so" libraries, there are searched separately
	# because we need to extract the relative path to mount them in the
	# correct path based on the guest's setup
	#
	# /usr/lib64 is common in Arch or RPM based distros, while /usr/lib/x86_64-linux-gnu is
	# common on Debian derivatives, so we need to adapt between the two nomenclatures.
	NVIDIA_LIBS="$(find \
		/host/usr/lib/i386-linux-gnu/ \
		/host/usr/lib/x86_64-linux-gnu/ \
		/host/usr/lib32/ \
		/host/usr/lib64/ \
		-iname "*nvidia*.so*" \
		-o -iname "libcuda*.so*" \
		-o -iname "libnvcuvid*.so*" \
		-o -iname "libnvoptix*.so*" 2> /dev/null || :)"
	for nvidia_lib in ${NVIDIA_LIBS}; do
		dest_file="$(printf "%s" "${nvidia_lib}" |
			sed "s|/host/usr/lib/x86_64-linux-gnu/|${lib64_dir}|g" |
			sed "s|/host/usr/lib/i386-linux-gnu/|${lib32_dir}|g" |
			sed "s|/host/usr/lib64/|${lib64_dir}|g" |
			sed "s|/host/usr/lib32/|${lib32_dir}|g")"

		# If file exists, just continue
		# this may happen for directories like /usr/lib/nvidia/xorg/foo.so
		# where the directory is already bind mounted (ro) and we don't need
		# to mount further files in it.
		if [ -e "${dest_file}" ]; then
			continue
		fi

		type="file"
		if [ -L "${nvidia_lib}" ]; then
			type="link"
		fi

		if [ "${type}" = "link" ]; then
			mkdir -p "$(dirname "${dest_file}")"
			cp -d "${nvidia_lib}" "${dest_file}"
			continue
		fi
		ensureTargetDir ${dest_file}
		cp -r "${nvidia_lib}" "${dest_file}" 

	done

	# Refresh ldconfig cache, also detect if there are empty files remaining
	# and clean them.
	# This could happen when upgrading drivers and changing versions.
	empty_libs="$(ldconfig 2>&1 | grep -Eo "File.*is empty" | cut -d' ' -f2)"
	if [ -n "${empty_libs}" ]; then
		# shellcheck disable=SC2086
		find ${empty_libs} -delete 2> /dev/null || :
		find /usr/ /etc/ -empty -iname "*nvidia*" -delete 2> /dev/null || :
	fi
echo "ACE: Timezone Integration"
rm /etc/localtime
cp $(realpath /host/etc/localtime) /etc/localtime
chmod 777 /etc/localtime 
