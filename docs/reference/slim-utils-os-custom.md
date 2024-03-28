---
layout: default
title: Custom OS support
---

# Customizing Lyrion Music Server using `Slim::Utils::OS::Custom`

If you've been working on porting SC to a new platform, a NAS or similar, you might have seen needs to patch Squeezebox Server to achieve your goal. Many of these changes were due to different file system layouts or other OS specifics. Some of them had been hardcoded into Slim::Utils::OSDetect or other modules for the officially supported platforms.
As of Squeezebox Server (formerly known as SqueezeCenter) version 7.3 there's a new infrastructure to better encapuslate and simplify such changes. While we do provide modules for the supported platforms, you can easily add your own platform support using a Slim::Utils::OS::Custom module.

## How does it work?

When Squeezebox Server is started, it's loading the module Slim::Utils::OSDetect. This module tries to detect the operating system Squeezebox Server is running on, and initializes the OS dependant code. This code is organized in classes, which inherit Slim::Utils::OS. These classes provide methods to query OS specific file paths, scanners, proxy detection and more.
If OSDetect finds Slim/Utils/OS/Custom.pm, it will try to load this before doing any of the other tests. This allows you to hook into Squeezebox Server by adding your own class. Only a few simple steps are needed:

* Create a new module Slim::Utils::OS::Custom which inherits from Slim::Utils::OS or one of its sub-classes. It's minimum might look like this:

```perl
package Slim::Utils::OS::Custom;

use strict;
use base qw(Slim::Utils::OS);

1;
```

* Overwrite some of the existing methods to add your own specifics:

```perl
package Slim::Utils::OS::Custom;

use strict;
use base qw(Slim::Utils::OS);

sub initDetails {
	my $class = shift;

	$class->{osDetails} = $class->SUPER::initDetails();
	$class->{osDetails}->{name} = "My very own Unix based OS";

	return $class->{osDetails};
}

sub initPrefs {
	my ($class, $prefs) = @_;

	$prefs->{scannerPriority}   = 20;
	$prefs->{resampleArtwork}   = 0;
	$prefs->{disableStatistics} = 1;
}

1;
```

All this does is create a new name for your OS, and override some default preferences.

## Available Hooks

* `initDetails()` - initialize a hash of OS details, called during initialization of the module

```perl
sub initDetails {
	my $class = shift;

	$class->{osDetails}->{os}     = 'Linux';
	$class->{osDetails}->{osName} = 'My Secret Linux';
}
```

* `details()` - return a reference to the details hash
* `initPrefs()` - called when preferences are initialized. Can be used to eg. define performance prefs for lower end hardware (see above example)
* `initSearchPath()` - initialize the search path for helper binaries
* `dirsFor()` - return paths for various items (strings, plugins, modules etc. - see Slim::Utils::OS for the complete list)
* `ignoredItems()` - return a hash of items which should be ignored in scans or when browsing the filesystem

```perl
sub ignoredItems {
	return (
		'bin'       => '/',
		'etc'       => '/',
		'lib'       => '/',
		'proc'      => '/',
		'root'      => '/',
		'sbin'      => '/',
		'tmp'       => '/',
		'usr'       => '/',
		'var'       => '/',
		'lost+found'=> 1,
	);
}
```

* `scanner()` - return path to an alternative scanner or location
* `getProxy()` - read proxy settings from underlying OS
* `getPriority()`/`setPriority()` - get/set server priority
* `dontSetUserAndGroup()` - return true if the server should not set the user and group (allowing to be run as root)
* `logRotate()` - add some method to do poor men's log rotation if the system doesn't do this for you
* `skipPlugins()` - return a list of plugins you don't want to be loaded on your system
* `canAutoUpdate()`, initUpdate(), getUpdateParams(), installerExtension(), installerOS() - enable and configure automatic downloading
* `directFirmwareDownload()` - Return true if you don't want Squeezebox Server to download and cache firmware upgrades for your players on your system. It will then tell the player to pull them directly from the source server.
* `canRestartServer()` - can the system restart the server?
* `restartServer()` - restart server

More hooks can be added if needed.
