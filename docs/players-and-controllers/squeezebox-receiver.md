---
layout: default
title: Squeezebox Receiver
---
# Squeezebox Receiver

<figure markdown="span">
  ![](assets/receiver_hero_500.jpg){ width="75%" }
</figure>

The Squeezebox Receiver (SBR), announced in January of 2008, is based on the Squeezebox2/v3 architecture, but lacks a display and headphone jack and is part of the Squeezebox Duet bundle, together with the Squeezebox Controller.

## Specifications

- CPU: Ubicom IP3K series, 250 MHz
- Dimensions: L: 156mm x W: 106mm (w/o connectors); 112.5mm (w/connectors) x H: 29.25mm
- Ethernet: True 100Mbps throughput; Shielded CAT5 RJ-45 connector; Connects to any 100Mbps or 10Mbps network; Auto-detects full duplex and half duplex modes; Automatic receive polarity correction; Maximum cable length: 100 meters (328 feet) + Auto Uplink (Auto MDIX)
- Wireless: 802.11g; supports WPA Personal, WPA2-AES and 64/128-bit WEP encryption; high speed PCI interface to radio module; bridging capability allows Ethernet devices to connect to the network through Squeezebox Wireless; dual internal antennas.
- Decoder: Software-based MP3, FLAC, Ogg Vorbis, WMA (except WMA Lossless), AIFF, WAV
- DAC: Wolfson® 24-bit WM8501, 44.1kHz & 48kHz
- Buffer RAM: 25Mb (approx. 200 seconds at 128Kbps) compresessed, plus 28Mb (10 seconds at 44.1 samples/sec) uncompressed
- ROM: Rewritable flash program memory, EEPROM configuration memory
- Power supply: 9V DC, regulated, center positive, sleeve ground. Connector: 1.05mm ID, 3.5mm OD, 7mm long. Min supply rating: 550mA
- Supported protocols: DHCP, ARP, IP, ICMP, UDP, Support for subnets/gateways (see documentation section on WANs), UDP-based SlimProto, TCP-based SlimProto and audio streaming, direct HTTP audio streaming, direct connection to MySqueezebox.com. Will automatically reconnect to LMS.
- Compatible with LMS/SBS version 7.0+. 

## Connecting a Squeezebox Receiver to your LMS

Before first use the Receiver needs to be connected to your LMS system using the Squeezebox Controller. In case a Controller is not available, the Receiver can be connected by using the Net::UDAP protocol. 

Jcrummy has created a tool for multiple platforms to take care of the initialization, which is called [SBCONFIG and can be found here](https://jcrummy.github.io/gosqueeze/). This tool can also be used for older Squeezebox systems, like Classic and Boom and is particularly of use when the VFD display fails.

### SBCONFIG instructions
1. Download and launch the relevant executable for your OS.
2. Select the network interface that is connect to the same LAN as your Receiver. If you have only 1 network interface there is no need to select one. Be sure to use a network cable. 
3. Make sure you have restored the factory settings and that the LED is blinking red. See below for clarification of the various LED color codes. 
4. Now type discover. If your device is detected you will see the MAC address and 0.0.0.0 as the IP.
5. Type configure and the device number (0 in most cases)
6. You now enter the programming mode
7. Set the LanGateway, the SqueezeCenterAddress and select Interface (1 for wired, 0 for wireless). For WLAN enter the name of the WirelessMode, WirelessSSID and the WirelessWPAPSK (this is the network key).
8. Commit your changes by typing save.
9. Restart your Receiver. If you did everything right, the light now turns green, signaling that an IP address has been acquired via DHCP.
10. Once the Receiver is connected to LMS, the light will turn white and the device shows up in the list of players.

- It may be recommendable to use wired network with the Receiver. There are reports that the wireless connections suffer from poor connection.

## Receiver LED codes
### SBR front button and LED
The Squeezebox Receiver has one button with a TricolorLED behind it.
Button usage
- To put Squeezebox Receiver into setup mode, press and hold the button for about 3 seconds or until it blinks slow red then release it. 
- To do a factory reset on Squeezebox Receiver, continue holding for a total of 6 seconds until it starts blinking fast red. Release and after factory reset, it will start flashing slower and be ready to set up. 
- If you press and hold the button while plugging in the Receiver, you'll see the button sequence through a series of colors and a set of ascending test tones will be played through the audio outputs. 
- When connected to Squeezebox Server or MySqueezebox.com the button is WHITE, press to pause the music. Press again to start the music up again. 
- While music plays the button is bright white; when paused it is dark white. 

### LED Color codes
| LED color | Meaning |
| ---- | ---- |
| <font color="red"> Red (solid) </font>|	Booting up |
|	Red (blinking slow) | Awaiting to be setup |
|	Yellow | Waiting for wireless to connect / Link down on ethernet |
|	Green |	Network connected, waiting for DHCP to get IP address (skipped when using static IP) |
|	Blue |	Waiting to connect to Squeezebox Server or MySqueezebox.com |
|	White |	Connected to Squeezebox Server or MySqueezebox.com |
|	White (blinking fast) |	Firmware update in progress |
|	Red (blinking fast) |	Factory Reset and xilinx update in progress |
|	Purple |	Hard error with blink codes, a number of blinks with a one second pause in between (Note: The white light might have a purplish tint. If it's not blinking, everything is normal.) |

### Hard error codes
| Number of blinks | Meaning |
| ---- | ---- |
| 1 blink |	MAC address missing/bad (checked second upon boot-up) |
| 2 blinks |	Wireless card missing/bad (checked first upon boot-up) |
| 3 blinks |	SNV failure/error |
| 4 blinks |	Upgrade error |
| 5 blinks |	CPLD XSVF file open error (xilinx file) |
| 6 blinks | UUID not set/all zeros (Checked third upon boot-up) |
