UBUNTU_CODENAME=noble

# preapre environment
prep:
	@sudo apt install -y cloud-image-utils p7zip-full wget xorriso

# build seed iso files
build_seed:
	@for server in server_seed_iso/*; do if [ -d "$$server" ]; then echo $$server && cloud-localds $$server-seed_$(shell date +"%Y%m%d").iso $$server/user-data $$server/meta-data; fi; done

# build Ubuntu autoinstall iso
build_os:
	@$(eval VERSION=$(shell curl https://cdimage.ubuntu.com/ubuntu-server/${UBUNTU_CODENAME}/daily-live/current/ | grep title | grep -o -P '(?<=Server).*(?=LTS)'))
	@mkdir ${UBUNTU_CODENAME}-autoinstall-iso && \
  wget -P ${UBUNTU_CODENAME}-autoinstall-iso https://cdimage.ubuntu.com/ubuntu-server/${UBUNTU_CODENAME}/daily-live/current/${UBUNTU_CODENAME}-live-server-amd64.iso && \
  7z -y x ${UBUNTU_CODENAME}-autoinstall-iso/${UBUNTU_CODENAME}-live-server-amd64.iso -o${UBUNTU_CODENAME}-autoinstall-iso/source-files && \
  mv ${UBUNTU_CODENAME}-autoinstall-iso/source-files/[BOOT]/ ${UBUNTU_CODENAME}-autoinstall-iso/BOOT && \
	cd ${UBUNTU_CODENAME}-autoinstall-iso && \
  echo "menuentry \"Autoinstall Ubuntu Server\" {" > grub_add.txt && \
  echo "  set gfxpayload=keep" >> grub_add.txt && \
  echo "  linux   /casper/vmlinuz quiet autoinstall ---" >> grub_add.txt && \
  echo "  initrd  /casper/initrd" >> grub_add.txt && \
  echo "}" >> grub_add.txt && \
  sed -i '/menu_color_highlight/r grub_add.txt' source-files/boot/grub/grub.cfg && \
  sed -i 's/timeout=30/timeout=1/g' source-files/boot/grub/grub.cfg && \
	cd source-files && \
  xorriso -as mkisofs -r \
  -V 'Ubuntu-Server $(VERSION)LTS amd64' \
  -o ../../ubuntu-${UBUNTU_CODENAME}-autoinstall_$(shell date +"%Y%m%d").iso \
  --modification-date='$(shell date +"%Y%m%d%H%M%S")00' \
  --grub2-mbr '../BOOT/1-Boot-NoEmul.img' \
  --protective-msdos-label \
  -partition_cyl_align off \
  -partition_offset 16 \
  --mbr-force-bootable \
  -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b '../BOOT/2-Boot-NoEmul.img' \
  -appended_part_as_gpt \
  -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  --grub2-boot-info \
  -eltorito-alt-boot \
  -e '--interval:appended_partition_2_start_1013254s_size_10068d:all::' \
  -no-emul-boot \
  -boot-load-size 10068 \
  . && \
	cd ../../ && \
	rm -rf ${UBUNTU_CODENAME}-autoinstall-iso
