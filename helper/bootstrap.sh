#!/bin/sh

set -ueo pipefail

#
# Bootstrap a clean FreeBSD installation to run Ansible
#
# ansible with password authentication is problematic, so we rely on this to 
# install a public key.
#

# FIXME: Not echo without -t?
read -p "Public key line: " pubkey

ssh freebsd@rpi 'umask 022 && mkdir -p /home/freebsd/.ssh && echo "'"$pubkey"'" > /home/freebsd/.ssh/authorized_keys'

ansible-playbook -K helper/bootstrap.yaml
