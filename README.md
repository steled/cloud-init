# Ubuntu cloud-init & autoinstall iso files

This repository is used to create [server_seed_iso](server_seed_iso) files for Ubuntu cloud-init
and also creates the Ubuntu autoinstall iso based on the [ubuntu_codename](ubuntu_autoinstall_iso/ubuntu_codename).

## server seed iso files

- the iso files are created based on the subfolders of [server_seed_iso](server_seed_iso)
- to create a new server seed iso file just create a new subfolder at [server_seed_iso](server_seed_iso)
- at the new folder create the following files:
  - `meta-data`
  - `user-data`
  - `network-config` (not needed for Ubuntu autoinstall)

## autoinstall iso files

- the autoinstall iso file is created based on the [ubuntu_codename](ubuntu_autoinstall_iso/ubuntu_codename)
- the iso is downloaded from https://cdimage.ubuntu.com/ubuntu-server/$ubuntu_codename/daily-live/current/$ubuntu_codename-live-server-amd64.iso
