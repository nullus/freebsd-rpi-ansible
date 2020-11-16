# FreeBSD RPi2 with Ansible

## Configure Rasperry Pi 2 to provide network services

### Getting started

1. Fetch/write a new [FreeBSD image](https://www.freebsd.org/where.html) on SD card:

       http GET https://download.freebsd.org/ftp/releases/arm/armv7/ISO-IMAGES/12.1/FreeBSD-12.1-RELEASE-arm-armv7-RPI2.img.xz > img.xz
       xzcat img.xz | sudo dd of=/dev/disk2 bs=1048576    
2. Boot RPi2 using new SD card
3. Do bootstrapping:

        # Create .ssh/config entry for provision host
        scp helper/bootstrap.sh freebsd@provision:
        ssh -t rpi 'sh bootstrap.sh'
        # Enter public key string when prompted
        ansible-playbook -K helper/bootstrap.yaml
        # ... this takes awhile
4. Create environment specific variables in env.yaml:

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

5. Run playbook to configure device:

       ansible-playbook -e @env.yaml site.yaml

### To Do

- Combine shell/ansible bootstrap
- Authoritative DNS for local domains (in-addr.arpa, in6.arpa)
- GPS hat/antenna to provide stratum 1 NTP clock

### Bugs

⚠️ Will need to attempt clean build again to determine if all dependency issues are resolved
