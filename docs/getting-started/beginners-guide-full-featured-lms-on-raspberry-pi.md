---
layout: default
title: Beginner's Guide for a full-featured LMS on Raspberry Pi
---

# Beginner's Guide for a full-featured LMS on Raspberry Pi

!!! note
    If you are looking for the most simple and cheap LMS setup (comparable to the now defunct MySqueezebox.com service) and just want to use internet streaming services, please follow [this guide](beginners-guide-lms-on-raspberry-pi.md).

This guide will not only make it possible to use internet streaming services on your Squeezeboxes, but you can also play your local music collection with your Squeezeboxes. The hardware mentioned in this guide is a bit more expensive than the hardware you need for [internet-streaming-only LMS](beginners-guide-lms-on-raspberry-pi.md), but you are a lot more flexible into the future.  

## Getting the hardware

These five parts are enough for your own powerful but energy-saving and long-lasting LMS music & radio server.

- Raspberry Pi 4B
- Enclosure (make sure to choose one specifically for your Raspberry model)
- Micro SD memory card, 8GB or higher
- Power Adapter 5V 3A
- Ethernet cable

[Here](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/#find-reseller){:target="_blank"} you can find a store in your area which sells these items. Some stores also sell these items as a bundle for your convenience. You can also use [rpilocator.com](https://rpilocator.com/) to check if local stores have the model you are looking for in stock.

There are other options than the 4B that will also work, such as the [Raspberry Pi 3B+](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/#find-reseller){:target="_blank"} or the [Raspberry Pi 5](https://www.raspberrypi.com/products/raspberry-pi-5/#find-reseller){:target="_blank"}. Please make sure you buy an enclosure and a power adapter that suits your model (2.5A power supply for the 3B+ and a 5A power supply for the Raspberry Pi 5).

## Installing and configuring the software

For new users to Raspberry Pi and LMS the easiest way to LMS is to install [piCorePlayer](https://www.picoreplayer.org/) (pCP). There is [already great guide for pCP](https://docs.picoreplayer.org/getting-started/), but for clarity, below are the steps for this particular combination of hardware:

1. [Download piCorePlayer](https://docs.picoreplayer.org/how-to/download_picoreplayer/) (use the 64-bits variant)
2. [Burn pCP to the SD card](https://docs.picoreplayer.org/how-to/burn_pcp_onto_a_sd_card/)
3. Eject the SD card and insert into the Raspberry Pi
4. Connect the Raspberry Pi with an ethernet cable to your router
5. Connect the power adapter to the Raspberry Pi

Congrats, piCorePlayer is now booting!

## After boot

After your new piCorePlayer has finished booting up, there are a few steps left to install and configure LMS:

1. [First determine the IP-address of the new piCorePlayer](https://docs.picoreplayer.org/how-to/determine_your_pcp_ip_address/). This IP-address is needed in the steps below.
2. Launch your web browser (eg. Edge, Firefox) and type: `http://[ip address from the previous step]`. Then, press Enter. The piCorePlayer web interface will open.
3. Go to the Main Page tab, then to `Resize FS` in `Additional functions`.
4. Enter the value 2000 MB and click on `Resize`. Wait until the operation is complete (pCP may restart).
5. At the bottom left of the page, click on `Player/server`.
6. Go to the `LMS` tab, then click on `Install`.
7. In the `LMS` tab, click on `Start LMS` and wait for the operation to finish (pCP may restart). The `LMS is running` signal is ticked in green.
8. Confirm that the first line `Set Autostart` is set to `Yes`.
9. Go to the `Tweaks` tab and give a name (Host name) to the LMS server (for instance `lyrion`). This name will be used to connect the Squeezebox to the server.

If you need any help with the steps above, please check [this guide](https://docs.picoreplayer.org/how-to/install_lms/) for more pointers.

## Connecting your Squeezebox to LMS

The last step is to switch your Squeezebox device from MySqueezebox.com to your LMS instance. Turn on your Squeezebox, go to "My Music", then select "Switch library...", click on the server name defined above, and... that's it, your Squeezebox is connected to your LMS 24/7 !

## Add your local music collection

Your Lyrion Music Server is able to serve your local music collection to your Squeezebox players. You can attach an external hard drive which contains all your music to the Raspberry Pi or, if you already have all your music available via a netwerk share, you can add this network share to the piCorePlayer.

### External hard drive

Before connection your external drive to the Raspberry, please make sure that the Raspberry is capable of supplying enough power to the external drive, or use an external power supply for the drive. Next, follow [this guide](https://docs.picoreplayer.org/how-to/add_4tb_usb_hdd/) to configure the drive on your piCorePlayer.

### Add network share

If you have your music collection already available on a file share (for instance on a NAS), you can follow [this guide](https://docs.picoreplayer.org/how-to/add_network_share/) to add the network share to your piCorePlayer.

## Troubleshooting

In case you encounter some problems please head over to the [forums](https://forums.slimdevices.com) for assistance. See also [this thread](https://forums.slimdevices.com/forum/user-forums/general-discussion/1668970-new-to-lms-get-help-here-installing-on-a-raspberry-pi/) which specifically deals with helping newcomers installing LMS on a Raspberry Pi.
