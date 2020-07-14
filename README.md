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
        ssh freebsd@provision 'sh bootstrap.sh'
        # Enter public key string when prompted
        ansible-playbook -K -i provision, helper/bootstrap.yaml
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

       ansible-playbook -e @env.yaml -i hosts site.yaml

### To Do

- Rewrite bootstrap as raw/no facts playbook (implement for upgrade?)
- ~~Ship logs externally (e.g. graylog?)~~ somewhat working Loggly config, but it's a bit bogus right now
- Determine a task/handler configuration for transition to provisioned
- Authoritative DNS for local domains (in-addr.arpa, in6.arpa)
- GPS hat/antenna to provide stratum 1 NTP clock

### Bugs

- First run (without network restart):

        RUNNING HANDLER [rdns : restart unbound] *******************************************************************************************
        fatal: [rpi]: FAILED! => {"changed": false, "msg": "unbound not running? (check /usr/local/etc/unbound/unbound.pid).\n[1572585006] unbound[3226:0] error: can't bind socket: Can't assign requested address for 192.168.92.8 port 53\n[1572585006] unbound[3226:0] fatal error: could not open ports\n/usr/local/etc/rc.d/unbound: WARNING: failed to start unbound\n"}
