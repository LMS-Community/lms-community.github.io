---
layout: default
title: How to migrate from Windows 32-bit build to 64-bit
---

# How to migrate from Windows 32-bit build to 64-bit

If you're running Lyrion Music Server on a Windows 64-bit system, we strongly recommend you install the 64-bit package.
It comes with more up to date libraries and doesn't rely on a tool which has been abandoned by its developers many years ago.

The 32-bit build system is currently relying on a virtual machine running on a 2014 Mac Mini... if that machine ceases operation,
the 32-bit Windows build will be gone. The build system will not be updated.

## Important to know

The new 64-bit version doesn't provide a toolbar icon, or a control panel. There's a tool in the Start menu to configure
the Lyrion Music Server startup mode. The remaining configuration happens through the LMS web UI [http://locahost:9000](http://locahost:9000).

## Uninstall Logitech Media Server (or Lyrion Music Server) 32-bit

Go to the Windows Start menu to run the LMS uninstaller. When asked whether you want to remove prefs and data, too, _decline_!
The 64-bit version is able to pick up the data from an older installation. So you won't have to re-configure everything.

## Install the 64-bit version

The first time you install the 64-bit version you'll have to be patient: the installer will bring
[Strawberry Perl](https://strawberryperl.com) to your system. This can take several minutes, but only needs to be done once.

Once the installation has completed LMS should be running, and you should be able to access it on [http://locahost:9000](http://locahost:9000).
