#!/bin/sh

set -ueo pipefail

#
# Bootstrap a clean FreeBSD installation to run Ansible
#

if ! [ -f "$1" ] ; then
  echo "$0: No pubkey file specified"
  exit 255
fi

mkdir -p /home/freebsd/.ssh

cat "$1" > /home/freebsd/.ssh/authorized_keys

pkg bootstrap -y

pkg install -y sudo python

cat << EOF > /usr/local/etc/sudoers.d/wheel_nopasswd
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
