#!/bin/bash

set -ouex pipefail

dnf5 -y copr enable bieszczaders/kernel-cachyos-lto
dnf5 -y remove kernel kernel-devel-matched kernel-core kernel-modules-core kernel-modules-extra
rm -r /usr/lib/modules/*
dnf5 -y install kernel-cachyos-lto kernel-cachyos-lto-devel-matched dkms


setsebool -P domain_kernel_load_modules on
