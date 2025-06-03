#!/usr/bin/env bash
MACHINE_HOSTNAME=maxhero-workstation
MAIN_USER_NAME=maxhero
TIMEZONE='America/Sao_Paulo'
PACKAGES=(
# Greetd
extra/greetd
extra/greetd-tuigreet

# Emulation
extra/qemu-full
extra/qemu-emulators-full
aur/waydroid

# CLI Tools
core/tar
core/xz
core/curl
extra/neofetch
extra/lm_sensors
extra/tree
extra/wget
extra/duf
extra/jq
extra/bc
extra/fd
extra/gdb
extra/gdb-common
extra/gdb-dashboard
extra/ddcutil
extra/nushell
extra/lshw
extra/fzf
extra/dog
extra/termshark
extra/magic-wormhole
extra/ipcalc
extra/mtr
extra/mosh
extra/ripgrep
extra/sshfs
extra/ghidra
extra/powerline-fonts
extra/openal
extra/wget
extra/mise
extra/git
extra/git-lfs
extra/git-crypt
extra/fasm
extra/unzip
extra/atac
extra/xdelta3
extra/tmux
extra/procs
extra/rsync
extra/unp
extra/task
extra/asciinema
extra/moreutils
extra/cage
aur/lazydocker

# DevOps Stuff
extra/aws-cli
extra/kubectl
extra/minikube
extra/k9s

# Video Editing
aur/davinci-resolve
extra/rocm-opencl-runtime

# Music + TTS
extra/timidity++
aur/voicevox-appimage

# Drivers
extra/dkms
extra/mesa

# Desktop Environment
extra/tela-circle-icon-theme-all
extra/i3-wm
extra/feh
chaotic-aur/eww
extra/gnome-themes-extra
extra/gtk-engine-murrine
extra/orchis-theme
extra/rofi
extra/rofi-calc
extra/rofi-emoji
extra/rofi-pass
extra/rofi-rbw
extra/dunst
extra/flamehot
extra/picom
extra/copyq
extra/gimp
extra/gparted
extra/xarchiver-gtk2
extra/pavucontrol
extra/easyeffects
extra/xdg-desktop-portal-gtk
extra/eog
extra/eog-docs
extra/eog-plugins
extra/qpwgraph
extra/thunar
extra/thunar-archive-plugin
extra/thunar-media-tags-plugin
extra/thunar-shares-plugin
extra/thunar-vcs-plugin
extra/thunar-volman

# Package Tooling
chaotic-aur/powerpill

# Browser
chaotic-aur/brave-bin

# Shells
extra/zsh
extra/zshdb
extra/zsh-autocomplete
extra/zsh-autosuggestions
extra/zsh-completions
extra/zsh-history-substring-search
extra/zsh-lovers
extra/zsh-syntax-highlighting
extra/bash-completion
chaotic-aur/oh-my-zsh-git

# Terminal
extra/ghostty
extra/ghostty-shell-integration

# Development
extra/neovim
extra/emacs
extra/inotify-tools

# Gaming
extra/lutris
extra/retroarch
extra/retroarch-assets-glui
extra/retroarch-assets-ozone
extra/retroarch-assets-xmb
chaotic-aur/librashader
chaotic-aur/pcsx2-avx-git
chaotic-aur/dolphin-emu-avx-git
chaotic-aur/retroarch-autoconfig-udev-git
chaotic-aur/proton-ge-custom-bin
chaotic-aur/lutris-git
aur/better-libretro-pcsx2-launcher-git
aur/libretro-db-tools
aur/libretro-meowpc98-git
aur/bizhawk-bin
extra/prismlauncher
multilib/steam
extra/oversteer

# Gaming/Wine
multilib/wine
multilib/wine-mono
extra/wine-gecko
multilib/winetricks
extra/vulkan-tools
extra/mangohud
extra/libpulse
multilib/lib32-mangohud
multilib/lib32-libpulse
multilib/lib32-alsa-lib
multilib/lib32-openal
multilib/lib32-mesa
multilib/lib32-vulkan-icd-loader
multilib/lib32-libx11
multilib/lib32-libxcomposite
multilib/lib32-libxrandr
multilib/lib32-libxinerama
multilib/lib32-libxcursor
multilib/lib32-libxi
multilib/lib32-libxfixes
multilib/lib32-libxrender
multilib/lib32-libxdamage
multilib/lib32-freetype2
multilib/lib32-libjpeg-turbo
multilib/lib32-gnutls
multilib/lib32-libldap
multilib/lib32-libxml2
multilib/lib32-giflib
multilib/lib32-libpng
multilib/lib32-sdl2
multilib/lib32-ncurses
multilib/lib32-zlib

# Gaming Optional
multilib/lib32-alsa-plugins
multilib/lib32-libcups
multilib/lib32-fluidsynth
multilib/lib32-gst-plugins-base
multilib/lib32-gst-plugins-good
multilib/lib32-v4l-utils
multilib/lib32-pipewire
multilib/lib32-libdecor
multilib/lib32-pipewire-jack

# Communication
extra/discord
extra/telegram-desktop
chaotic-aur/zoom

# Fonts
extra/adobe-source-han-sans-otc-fonts
extra/adobe-source-han-serif-otc-fonts
extra/adobe-source-han-serif-jp-fonts
extra/noto-fonts
extra/noto-fonts-cjk
extra/noto-fonts-emoji
extra/noto-fonts-extra
extra/otf-font-awesome

# Tooling
extra/obsidian
aur/ticktick

# Hardware related
aur/wootility-appimage

# Bluetooth Support
extra/bluez
extra/bluez-utils

# Programming stuff
core/gcc
core/clang
extra/nasm
extra/luajit
extra/erlang
extra/elixir
extra/nodejs
extra/postgresql
extra/postgresql-docs
extra/postgresql-ip4r
extra/postgresql-libs
extra/aarch64-linux-gnu-binutils
extra/mingw-w64-binutils

# Game Development
extra/godot
extra/sdl

# Other programs
extra/bitwarden
extra/bitwarden-cli
extra/filezilla
extra/veracrypt
extra/cage
chaotic-aur/qbittorrent-enhanced
extra/mpv
extra/obs-studio
extra/ffmpeg
extra/yt-dlp

# DKMS
extra/v4l2loopback-dkms
aur/binder_linux-dkms

# Podman
extra/podman
extra/podman-compose
extra/podman-desktop
extra/podman-docker
)

setup_users(){
useradd -s /usr/bin/nologin greeter
useradd -M -s /usr/bin/bash $MAIN_USER_NAME
}

setup_chaotic_aur(){
CHAOTIC_AUR_BASE_URL="https://cdn-mirror.chaotic.cx/chaotic-aur"
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U "$CHAOTIC_AUR_BASE_URL/chaotic-keyring.pkg.tar.zst"
pacman -U "$CHAOTIC_AUR_BASE_URL/chaotic-mirrorlist.pkg.tar.zst"
}

setup_time(){
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc
timedatectl set-ntp true
}

setup_bluetooth(){
systemctl enable bluetooth.service
}

setup_numlock(){
cat <<EOF > /etc/systemd/system/numlock.service
[Unit]
Description=numlock

[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl enable /etc/systemd/system/numlock.service
}

setup_mkinitcpio(){
mkinitcpio -P
}

setup_networking(){
echo "$MACHINE_HOSTNAME" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1 localhost
::1 localhost

# Block Facebook, Twitter, Instagram to avoid Doom Scrolling.
# Unfortunately, there is no way to DNS block just Youtube Shorts.
127.0.0.1 facebook.com www.facebook.com twitter.com www.twitter.com instagram.com www.instagram.com x.com www.x.com

127.0.0.2 $MACHINE_HOSTNAME
::1 $MACHINE_HOSTNAME
EOF
}

setup_locale(){
cat <<EOF > /etc/locale.gen
ja_JP.UTF-8 UTF-8
en_US.UTF-8 UTF-8
en_GB.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8
EOF

cat <<EOF > /etc/locale.conf
LANG=ja_JP.UTF-8
LANGUAGE=ja_JP.UTF-8
LC_ALL=ja_JP.UTF-8
LC_MONETARY=pt_BR.UTF-8
LC_NUMERIC=pt_BR.UTF-8
LC_TIME=ja_JP.UTF-8
EOF

cat <<EOF > /etc/vconsole.conf
KEYMAP=us
FONT=Lat2-Terminus16
EOF

locale-gen
}

setup_postgres(){
cat <<EOF > /var/lib/postgres/data/pg_hba.conf
# TYPE  DATABASE USER            ADDRESS     METHOD
local        all  all                         trust
host         all  all    192.168.0.88/32      trust
host         all  all       127.0.0.1/32      trust
host         all  all            ::1/128      trust
EOF

cat <<EOF > /var/lib/postgres/data/postgresql.conf
listen_addresses = '*'
EOF

systemctl enable postgresql

initdb --locale=C.UTF-8 --encoding=UTF8 -D /var/lib/postgres/data --data-checksums
}

setup_greetd(){
cat <<EOF > /etc/greetd/config.toml
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd i3 --user-menu --remember"
user = "greeter"
EOF

systemctl enable greetd.service
}

setup_pacman(){
cat <<EOF > /etc/pacman.conf
[options]
Architecture = x86_64
ParallelDownloads = 10
VerbosePkgLists
Color
TotalDownload
CheckSpace
VerbosePkgLists
ILoveCandy

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF

install_packages(){
pacman -Syu "$PACKAGES[@]"
}

setup_udev(){
cat <<EOF > /etc/udev/99-local.rules
# Supporting VFIO
SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"

# This rule is needed for basic functionality of the controller in
# Steam and keyboard/mouse emulation
SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
# This rule is necessary for gamepad emulation; make sure you
# replace 'pgriffais' with a group that the user that runs Steam
# belongs to
KERNEL=="uinput", MODE="0660", GROUP="pgriffais", OPTIONS+="static_node=uinput"
# Valve HID devices over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"
# Valve HID devices over bluetooth hidraw
KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
# DualShock 4 over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
# Dualsense over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0666"
# DualShock 4 wireless adapter over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0666"
# DualShock 4 Slim over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
# DualShock 4 over bluetooth hidraw
KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0666"
# DualShock 4 Slim over bluetooth hidraw
KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0666"

# -============================== Wooting Portion ===================================-
# Wooting One Legacy
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", TAG+="uaccess"

# Wooting One update mode
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2402", TAG+="uaccess"

# Wooting Two Legacy
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", TAG+="uaccess"

# Wooting Two update mode
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2403", TAG+="uaccess"

# Generic Wootings
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", TAG+="uaccess"
EOF

}

setup_install_binder_linux(){
cat <<EOF > /etc/modules-load.d/binder_linux.conf
# Load binder_linux at boot
binder_linux
EOF

cat << EOF > /etc/modprobe.d/binder_linux.conf
# Options for binder_linux
options binder_linux devices=binder,hwbinder,vndbinder
EOF
}

setup_install_dotfiles(){
  if  [[ ! -d /home/$MAIN_USER_NAME/projects/config ]] {
	git clone git@github.com:themaxhero/dot-files.git ~/projects/config
  }
}

setup_bootloader(){
cat <<EOF > /boot/loader/loader.conf
default arch
timeout 3
editor no
EOF

cat <<EOF > /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
initrd  /initramfs-linux-fallback.img
options root=UUID=YOUR-ROOT-UUID rw $KERNEL_PARAMS
EOF
}

setup_users
setup_time
setup_chaotic_aur
setup_numlock
setup_networking
setup_locale
setup_pacman
setup_udev
install_packages
setup_greetd
setup_bluetooth
setup_install_binder_linux
setup_postgres
setup_install_dotfiles
setup_bootloader
