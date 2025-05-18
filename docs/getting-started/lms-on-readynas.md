# LMS on ReadyNAS

**Important:** These instructions assume familiarity with SSH, knowledge of how to copy files from your PC to your NAS, and awareness of the risks of logging in to your NAS as root and typing stuff at the command line.

The procedures here work on my system (ReadyNAS Pro running OS 6.10.10, with LMS 9.1.0); there are no guarantees that they will work on yours.

[Update Audio::Scan to version 1.10](#update-audioscan-to-version-110)

(more topics to follow)

## Update Audio::Scan to version 1.10

### Rationale

ReadyNAS OS 6.10.10 uses Perl version 5.20, and LMS includes a number of third-party Perl modules, built for nearly a dozen versions of Perl including 5.20.

But LMS's early-version modules have not been updated along with the later ones. The Audio::Scan module, for example, is provided by LMS at version 1.10 (late 2024) for newer Perls, but only at version 0.99 (2017) for our old Perl.

Version 1.10 has a number of improvements over 0.99, so we will upgrade to it.

### Instruction Summary

To update the Audio::Scan module to 1.10:

- Copy the LMS third-party Perl code from the LMS Github account to your own Github account.
- Modify the build script to support your old 5.20 version of Perl, and then build the Audio::Scan module on Github's computers.
- Download the module to your PC, and then copy it to specially-named files on your NAS (specially-named so that they won't be overwritten by LMS's official files when you update LMS).
- Stop LMS, copy from the specially-named files to regularly-named files, then restart LMS. You'll also perform this last step any time you update LMS.

### Detailed Instructions

1. Make a free GitHub account. Log in to it.
2. Go to the official LMS third-party repo: https://github.com/LMS-Community/slimserver/tree/public/9.1
3. Click the Fork button in the upper-right to make a copy of the repo in your account. A page will appear with some options -- leave them alone and click Create Fork. You will be taken to your copy of the repo at https://github.com/USERNAME/slimserver-vendor.
4. Click the CPAN folder to open it. Click the Docker subfolder to open it. Click the Dockerfile.debian file to view it.5. Click the pencil icon in the upper right to edit the file.
6. Change line 2 from this:
```
FROM debian:testing
```
to this:
```
FROM debian/eol:jessie
```
7. Click the Commit Changes button. A dialog box will pop up -- leave all the options alone and click Commit Changes.
8. Find the Actions link at the top of the page and click it. A warning will appear. Click "I understand my workflows, go ahead and enable them".
9. Click the "Build Perl CPAN modules for Lyrion Music Server" link at the left.
10. Click the Run Workflow button at the right. A menu will drop down.
11. In the "Specific module you'd like to build" option, type
```
Audio::Scan
```
12. Click Run Workflow. In a few seconds the workflow will appear with a yellow "In progress" indicator. After a couple minutes, the indicator will become a green checkmark.
13. Click the "Build Perl CPAN modules for Lyrion Music Server" link next to the green checkmark. A page showing the build artifacts will appear.
14. At the bottom of the page, click the "CPAN-debian" link or the Download icon to the far right of it. A file, CPAN-debian.zip, will be downloaded to your PC.
15. Unzip the file. Inside is a directory tree with a directory called 5.20 at the top.
16. SSH into your NAS. In the /usr/share/squeezeboxserver/CPAN/arch/5.20 directory, type:
```
mkdir Audio
```
17. Using whatever method works for you -- WinSCP, FTP, CIFS/Samba, USB flash drive, etc -- copy `CPAN-debian/5.20/x86_64-linux-gnu-thread-multi/Audio/Scan.pm` from your PC to `/usr/share/squeezeboxserver/CPAN/arch/5.20/Audio/Scan110.pm` on your NAS (note that the filename on the NAS is `Scan110.pm`, not `Scan.pm`).
18. Use the same method to copy `CPAN-debian/5.20/x86_64-linux-gnu-thread-multi/auto/Audio/Scan/Scan.so` from your PC to `/usr/share/squeezeboxserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Audio/Scan/Scan110.so` on your NAS (note that the filename on the NAS is `Scan110.so`, not `Scan.so`).
19. On the NAS, stop LMS, copy the `Scan110.pm` and `Scan110.so` files to `Scan.pm` and `Scan.so` files in the same directories, and then restart LMS:
```
systemctl stop lyrionmusicserver
cp /usr/share/squeezeboxserver/CPAN/arch/5.20/Audio/Scan110.pm /usr/share/squeezeboxserver/CPAN/arch/5.20/Audio/Scan.pm
cp /usr/share/squeezeboxserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Audio/Scan/Scan110.so /usr/share/squeezeboxserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
systemctl start lyrionmusicserver
```
20. Go to the Information page in LMS settings. It will say that Audio::Scan is version 1.10.

**Important:** Every time you update LMS, you must perform step 19 afterward (LMS won't start otherwise).

### Undo
To revert to the official Audio::Scan:

1. Delete your new `Scan.pm` and `Scan.so` files:
```
rm /usr/share/squeezeboxserver/CPAN/arch/5.20/Audio/Scan.pm
rm /usr/share/squeezeboxserver/CPAN/arch/5.20/x86_64-linux-thread-multi/auto/Audio/Scan/Scan.so
```
2. Update LMS as usual.
