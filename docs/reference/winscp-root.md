---
layout: default
title: WinSCP as root
---

# How to use WinSCP as user `root`

## Introduction

For an introduction to using WinSCP with an example see "[WinSCP How To](winscp.md)".

## Instructions

Normally I use SFTP or SCP as File Protocal but sometimes one is denied permission to perform the task and one needs to utilise the user `root`.

* Stop LMS

* Fill in the login detail as required and then click on Advanced

![](assets/winscp/1-root-winscp.png)

* In the window that opens click on the following areas in sequence: "Shell"

![](assets/winscp/2-root-winscp.png)

* then "`sudo su`" from the dropdown

![](assets/winscp/3-root-winscp.png)

* then on OK

![](assets/winscp/4-root-winscp.png)

* The window will close and then click on Login

This is a rpi 4B with LMS installed on the RPiOS Bookworm Lite 64 bit:

![](assets/winscp/5-root-winscp.png)

