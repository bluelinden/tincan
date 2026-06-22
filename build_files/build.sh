#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 config-manager enable terra
dnf5 config-manager enable terra-extras
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons

dnf5 -y install --allowerasing tlp tlp-pd tlp-rdw

# base utilities
dnf5 install -y \
  helix \
  fish \
  dkms-v4l2loopback \
  layer-shell-qt

# gui apps
dnf5 install -y \
  vicinae \
  zed

dnf5 swap -y iwd wpa_supplicant

dnf5 -y swap zram-generator-defaults cachyos-settings
dnf5 -y copr disable bieszczaders/kernel-cachyos-addons

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
