#### /bin
/bin is a directory in the linux root directory that contains necessary binaries for your system to operate. These "binaries" are just another word for programs or applications. The ones in this folder are basic terminal [[Commands]] like `ls`, `cat`, `chmod`, etc. 

Also in the same vein, /sbin is another file in the root directory that is short for system binaries. These are binaries that a system admin would use and a standard user wouldn't have access to without permission.

These files contain the files that need to be accessible when running in [[Single User Mode]], as opposed to the multi-user mode, which is standard.

Programs are usually not installed into these files.

#### /boot
This folder shouldn't be touched without proper understanding or reason.

Its how your pc boots. The [[Bootloader]] lives here.

#### /dev
This is where your devices live. Any piece of hardware making your pc work will be in here. A disk for storage could be found at `/dev/sda` and a partition would be found at `/dev/sda1` and `/dev/sda2` and so on. 

Applications will often be accessing this folder, and users shouldn't really be messing around in here.

#### /etc
stands for etcetera 

This is where all of your system wide [[Configurations]] are stored. For example in the `/etc/apt` folder you would find your sources, which are all of the repos that your computer accesses to get files and stuff. It also contains various system wide settings.

#### /lib
This is where all of the system libraries are stored. These libraries allow the computer and certain code to perform various functions. This libraries are required by `/bin` and `/sbin` 

#### /media and /mnt
`/mnt` stands for mount. These two directories are where your other storage drives are found. Think a usb flash drive or even a second hard drive.

Most OS's do this for you in the `/media` folder, but if for whatever reason you need to mount one yourself, use the `/mnt` folder. Do not mess with `/media`, the system should do that for you.

#### /opt
This is the "optional" folder. This is where software that has been installed usually exist. Software like a vpn, printer functionality, or software you have made yourself.

#### /proc
Contains lots of information about the system and its current processes. If you co to your system monitor and look at the process ID then go to `/proc/<ID>`, you can find various information on that running process