#!/bin/bash

# Exit on error
set -e

user="joilar"

# Interactive

useradd -m -G users,wheel -s /bin/bash $user
passwd $user

# Non-interactive

# Set portage to never update sys-kernel/gentoo-sources
mkdir -p /etc/portage/package.mask
echo "sys-kernel/gentoo-sources" > /etc/portage/package.mask/gentoo-sources

emerge --sync
emerge --oneshot sys-apps/portage

# Pre-built binary packages
# GCC fails to build with an out of memory error so we'll just get the binary package
getuto
emerge --getbinpkgonly --nodeps sys-devel/gcc
eselect gcc set x86_64-pc-linux-gnu-14

# Dependencies needed by later setup stages
emerge app-admin/sudo app-misc/screen

# Do the full update and upgrade in a screen session.
# screen -S 'update' -d -m $HOME/update.gentoo.sh

# Update sudoers
# Doesn't work if you're tee-ing the output. Echo the command asking the admin to do it instead.
# visudo
