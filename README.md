# FreeBSD RPi2 with Ansible

## Configure Rasperry Pi 2 to provide network services

### Getting started

1. Fetch/write a new [FreeBSD image](https://www.freebsd.org/where.html) on SD card using [Raspberry Pi Imager](https://www.raspberrypi.org/software/):

       http GET https://download.freebsd.org/ftp/releases/arm/armv7/ISO-IMAGES/12.2/FreeBSD-12.2-RELEASE-arm-armv7-RPI2.img.xz > ~/Documents/FreeBSD-12.2-RELEASE-arm-armv7-RPI2.img.xz
2. Boot RPi2 using new SD card
3. Create an SSH key, and add SSH configuration (if required)
4. Do bootstrapping with `helper/bootstrap.sh`. you'll be asked for SSH public key, initial login password (`freebsd`), and BECOME password (`root`)
5. Create environment specific variables in env.yaml:

       ---
       admin_email: ...
       root_password_hash: ...
       loggly_user_token: ...
       site_domain: ...
       network_aliases:
         rpi: ...
       default_router: ...
       local_networks:
       - prefix: ...
         prefixlen: ...
         netmask: ...
       services:
         rpi:
           dns:
             addresses:
             - ...
           ntp:
             addresses:
             - ...
           ssh:
             addresses:
             - ...
           airplay:
             name: ...

6. Run playbook to configure device:

       ansible-playbook -e @env.yaml site.yaml

### To Do

- Hook bootstrapping/provisioning together with invoke
- Authoritative DNS for local domains (in-addr.arpa, in6.arpa)
- GPS hat/antenna to provide stratum 1 NTP clock

### Bugs

TBD
