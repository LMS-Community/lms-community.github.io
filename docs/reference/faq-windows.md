---
layout: default
title: Lyrion Music Server on Windows - Frequently Asked Question
---


# FAQ: Lyrion Music Server on Windows

## After installation I'm told Lyrion Music Server wasn't started. What can I do?


## Can I have more than one music folder?

## How can I connect to my music on a NAS?


## I can't connect to my NAS using my Microsoft Account. What's wrong with it?

## Where's the tray icon to start/stop Lyrion Music Server?

The tool to build the old tray icon is no longer available. Starting with Logitech Music Server 9.0 we can no longer provide that tool.

But you might be interested in this [Service Tray](https://www.coretechnologies.com/products/ServiceTray/) utility. It can be configured to start/stop the LMS service and the icon in the system tray has colors so you can see the status of your service that you configured it for. And it's free to use.

[Control any Windows Service with a Taskbar Tray Icon](https://www.coretechnologies.com/products/ServiceTray/).

## Lyrion Music Server doesn't restart properly after installing or updating a plugin.  How can I fix this?

You may find that after installing a new plugin, or if restarting for any other reason, that LMS does not restart and that you need to start the service manually.  This can be caused by the LMS service taking too long to start.  Windows has a 30 second service startup timeout by default, which can be too short depending on a number of factors.  This 30 second default can be changed by editing the Windows Registry by using the process described here in Microsoft Learn:  https://learn.microsoft.com/en-us/troubleshoot/windows-server/system-management-components/service-not-start-events-7000-7011-time-out-error The process may looking daunting, but it only needs to be done once.

You can start by changing the timeout value to 60 seconds, as suggested in the link.
