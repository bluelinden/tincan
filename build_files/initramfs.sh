#!/bin/bash

set -ouex pipefail

KERNEL_VERSION="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-cachyos-lto | head -n 1)"

# Generate module dependencies
depmod -a "${KERNEL_VERSION}"

# Handle vmlinuz placement
# We check if the files are physically different (-ef) before attempting a copy
VMLINUZ_SOURCE="/lib/modules/${KERNEL_VERSION}/vmlinuz"
VMLINUZ_TARGET="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"

if [[ -f "${VMLINUZ_SOURCE}" ]]; then
    if ! [[ "${VMLINUZ_SOURCE}" -ef "${VMLINUZ_TARGET}" ]]; then
        mkdir -p "/usr/lib/modules/${KERNEL_VERSION}"
        cp "${VMLINUZ_SOURCE}" "${VMLINUZ_TARGET}"
    else
        echo "vmlinuz already exists at target via symlink, skipping copy."
    fi
fi


export DRACUT_NO_XATTR=1
dracut --force --no-hostonly \
  --kver "${KERNEL_VERSION}" \
  --reproducible --add-drivers "btrfs nvme xfs ext4" \
  -v --add ostree \
  -f "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

chmod 0600 "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"
