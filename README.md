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

5. Run playbook to configure device:

       ansible-playbook -e @env.yaml -i hosts site.yaml

### To Do

- Rewrite bootstrap as raw/no facts playbook (implement for upgrade?)
- ~~Ship logs externally (e.g. graylog?)~~ somewhat working Loggly config, but it's a bit bogus right now
- Make Airplay name more descriptive
- Determine a task/handler configuration for transition to provisioned