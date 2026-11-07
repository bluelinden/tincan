#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 -y install terra-release-extras

dnf5 config-manager enable terra
dnf5 config-manager enable terra-extras

# why the fuck?? seemed to be an issue with cOS kernel. not minding it for now.
# rpm --erase fdk-aac-2.0.3-1.fc44.x86_64 --nodeps


dnf5 -y copr enable bieszczaders/kernel-cachyos-addons

dnf5 -y install --allowerasing tlp tlp-pd tlp-rdw

# base utilities
dnf5 install -y \
  helix \
  fish \
  layer-shell-qt \
  wget \
  libvirt \
  intel-opencl \
  oneapi-level-zero \
  intel-level-zero

  # dkms-v4l2loopback \

# gui apps
dnf5 install -y \
  vicinae \
  zed \
  gamescope \
  steam \
  extest

dnf5 install -y uutils-coreutils

dnf5 swap -y wpa_supplicant iwd

dnf5 -y swap zram-generator-defaults cachyos-settings
dnf5 -y copr disable bieszczaders/kernel-cachyos-addons

# install qmk helper udev stuff
wget https://github.com/qmk/qmk_udev/releases/latest/download/qmk_id-linuxX64 -O /tmp/qmk_id
wget https://github.com/qmk/qmk_udev/releases/latest/download/50-qmk.rules -O /tmp/50-qmk.rules
wget https://github.com/ValveSoftware/steam-devices/blob/master/60-steam-input.rules -O /tmp/60-steam-input.rules
install -m755 -D /tmp/qmk_id /usr/lib/udev/qmk_id
install -m644 -D /tmp/50-qmk.rules /etc/udev/rules.d/50-qmk.rules
install -m644 -D /tmp/60-steam-input.rules /etc/udev/rules.d/60-steam-input.rules

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
