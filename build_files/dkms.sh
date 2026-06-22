#!/bin/bash
set -ouex pipefail
KVER=$(ls /usr/lib/modules | grep cachyos | tail -1)
dkms autoinstall -k "$KVER"
