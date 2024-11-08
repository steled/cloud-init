# Ubuntu cloud-init & autoinstall iso files

This repository is used to create [server_seed_iso](server_seed_iso) files for Ubuntu cloud-init
and also creates the Ubuntu autoinstall ISO based on the `UBUNTU_CODENAME` variable in [Makefile](Makefile).

## server seed iso files

- the iso files are created based on the subfolders of [server_seed_iso](server_seed_iso)
- to create a new server seed iso file just create a new subfolder at [server_seed_iso](server_seed_iso)
- at the new folder create the following files:
  - `meta-data`
  - `user-data`
  - `network-config` (not needed for Ubuntu autoinstall)

## autoinstall iso files

- the autoinstall iso file is created based on the `UBUNTU_CODENAME` variable in [Makefile](Makefile)
- the iso is downloaded from https://cdimage.ubuntu.com/ubuntu-server/$ubuntu_codename/daily-live/current/$ubuntu_codename-live-server-amd64.iso

## server installation

- prepare one USB stick with `FAT32` and name the stick `cidata`
- copy the files `meta-data` and `user-data` into the root folder of this USB stick

- prepare a second USB stick with the `ubuntu-UBUNTU_CODENAME-autoinstall_DATE.iso`
- you can use a tool like [Rufus]()
- for a detailed How-To see Ubuntu Tutorials of [Create a bootable USB stick with Rufus on Windows](https://ubuntu.com/tutorials/create-a-usb-stick-on-windows)
