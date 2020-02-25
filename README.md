# FreeBSD RPi2 with Ansible

## Configure Rasperry Pi 2 to provide network services

### Getting started

1. Fetch/write a new [FreeBSD image](https://www.freebsd.org/where.html) on SD card:

       http GET https://download.freebsd.org/ftp/releases/arm/armv7/ISO-IMAGES/12.1/FreeBSD-12.1-RELEASE-arm-armv7-RPI2.img.xz > img.xz
       xzcat img.xz | sudo dd of=/dev/disk2 bs=1048576    
2. Boot RPi2 using new SD card
3. Transfer public key, and bootstrap script to RPi2
4. Run bootstrap script on RPi2:

       sh bootstrap.sh pubkey
5. Create environment specific variables in env.yaml:

       ---
       admin_email: <your email>
5. Run playbook to configure device:

       ansible-playbook -e @env.yaml -i hosts site.yaml

### To Do

- Rewrite bootstrap as raw/no facts playbook
- Ship logs externally (e.g. graylog?)
- Make Airplay name more descriptive
- ~~Use facts to determine network interface name?~~ This probably doesn't make sense once we have configured addresses statically
- Configure static addresses/IPv6
