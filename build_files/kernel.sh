#!/bin/bash

set -ouex pipefail

dnf5 -y copr enable bieszczaders/kernel-cachyos-lto

# from the Bazzite project
# Remove Existing Kernel
for pkg in kernel kernel{-core,-modules,-modules-core,-modules-extra,-tools-libs,-tools}; do
    rpm --erase "${pkg}" --nodeps
done

# # cleanup leftovers that are not covered by kernel-* packages for some reason
# rm -rf /usr/lib/modules

dnf5 -y install kernel-cachyos-lto kernel-cachyos-lto-devel-matched dkms


setsebool -P domain_kernel_load_modules on
dnf5 -y copr disable bieszczaders/kernel-cachyos-lto
