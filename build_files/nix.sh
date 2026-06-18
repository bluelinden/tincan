#!/bin/bash

set -ouex pipefail

dnf5 install -y nix nix-daemon
mkdir -p /nix