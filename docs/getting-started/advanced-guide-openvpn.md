---
layout: default
title: Advanced guide to OpenVPN on SB Radio/Touch
---

# Advanced guide to OpenVPN on SB Radio/Touch

This guide describes the procedure to install OpenVPN on your Squeezebox Radio *(`baby`)* or Squeezebox Touch *(`fab4`)*.  
You can use this to connect your Squeezebox player to your remote home network using OpenVPN. This guide assumes you have a functioning OpenVPN setup on your network. Also this guide assumes basic knowledge of \*nix administration (especially for the usage of `vi`).

## OpenVPN installation

!!! note
    Since community firmware version 9.0.1r17023 the `openvpn` binary and the `tun` kernel module are already included and even situated in the appropriate locations. If your are on this or a newer firmware, please skip any steps relating those files and directly proceed with creating `TUN.ovpn`.

We need the `openvpn` binary and the `tun` kernel module for the SB Radio/Touch and your `ovpn.config` as text.

Download the latest `baby-openvpn-x.y.z.zip` or `fab4-openvpn-x.y.z.zip` from [Ralphy's repository](https://sourceforge.net/projects/lmsclients/files/squeezeos/) and then copy it into the SB Radio/Touch:

=== "Radio"
    ```bash
    scp -O /path/to/baby-openvpn-x.y.z.zip root@RADIO-IP:/dev
    ```

=== "Touch"
    ```bash
    scp -O /path/to/fab4-openvpn-x.y.z.zip root@TOUCH-IP:/dev
    ```

Then we `ssh` into the SB Radio/Touch and enter the following commands:

=== "Radio"

    ```bash
    ssh root@RADIO-IP
    cd /dev
    unzip baby-openvpn-x.y.z.zip
    mv /dev/openvpn /usr/sbin
    chmod 755 /usr/sbin/openvpn
    mv /dev/tun.ko /lib/modules/$(uname -r)
    mkdir -p /etc/openvpn
    ```

=== "Touch"

    ```bash
    ssh root@TOUCH-IP
    cd /dev
    unzip fab4-openvpn-x.y.z.zip
    mv /dev/openvpn /usr/sbin
    chmod 755 /usr/sbin/openvpn
    mv /dev/tun.ko /lib/modules/$(uname -r)
    mkdir -p /etc/openvpn
    ```

Next we create the file with `vi` and there you enter the text of your ovpn.config. Make sure you insert `auth-user-pass /etc/openvpn/up` into the config.
Please also remove any of the lines relating to downgrading user privileges. Placing `# ` in front of them turns them into comments:

```bash
vi /etc/openvpn/TUN.ovpn
```

```
# Downgrade privileges after initialization (non-Windows only)
# user nobody
# group nogroup
```

Next create the file `up` and enter your vpn username in first line and password in second line:
```bash
vi /etc/openvpn/up
```
!!! note
    Now it is a good time to decide wether to establish the VPN-connection at boot (`rcS.local`) or on demand using an applet. The former is described in detail in the following section regarding editing `rcS.local`. The latter is right below it just above the `settime` script.

Next is the `rcS.local` file which runs the stuff at boot:
```bash
vi /etc/init.d/rcS.local
```

We paste these two commands into that file:

=== "Radio"

    ```bash
    # Load the tunnel kernel module.
    insmod /lib/modules/$(uname -r)/tun.ko
    # Start openvpn
    /usr/sbin/openvpn --config /etc/openvpn/TUN.ovpn --daemon
    ```

=== "Touch"

    ```bash
    # Load the tunnel kernel module.
    insmod /lib/modules/$(uname -r)/tun.ko
    # Start openvpn
    /usr/sbin/openvpn --config /etc/openvpn/TUN.ovpn --daemon
    ```

Then `chmod` that file:
```bash
chmod 755 /etc/init.d/rcS.local
```

As an option it is feasible to only establish a VPN connection if your player switches between your home network and some remote one. Thus, the need might arise in enabling it if necessary and without any further code changes. For that purpose alone you could grab applet and activate it on your player. 

[VPN applet for SB Radio & Touch](https://forums.lyrion.org/forum/user-forums/3rd-party-software/1804469) but you still have to follow the rest of the instructions in this tutorial.

Then we put a script which gets NTP time when network is up. We need this to get the right time to connect to vpn.
```bash
vi /etc/network/if-up.d/settime
```

Put the following contents into that file:
```bash
#!/bin/sh
# /etc/network/if-up.d/settime
# Sets the hardware clock from an NTP server on reboot
# Replace this with the address of your local time server
# or with a public NTP server like pool.ntp.org or time.google.com
NTP_SERVER=pool.ntp.org
# Log file with system time before and after synchronisation
LOG_FILE="/var/log/settime.log"
if [ "$METHOD" != "loopback" ]; then
date >> $LOG_FILE
echo "Synchronizing time with $NTP_SERVER via $IFACE" >> $LOG_FILE
msntp -r -P no $NTP_SERVER && hwclock -w -u
date >> $LOG_FILE
fi
```

Then we `chmod` that file:
```
chmod +x /etc/network/if-up.d/settime
```

That’s it, we are done, hope it is running fine. We can now reboot:
```
reboot
```
