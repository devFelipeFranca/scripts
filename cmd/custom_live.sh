#!/bin/sh
#https://help.ubuntu.com/community/LiveCDCustomization
#set -e

if [ "$1" = "" ];then
        echo "Call this script with part1, part2 or clean as argument"
        exit 0
fi
IMAGE_NAME="LIVE_TEST"
ISO="kubuntu-12.04.2-desktop-i386.iso"
BUILDDIR=var
UBUVERSION="precise"
FILES=files
FILESKDE=${FILES}/kde

mkdir -p ${BUILDDIR}/mnt
mkdir -p ${BUILDDIR}/extract-cd


if [ "$1" = "part1" ];then
        #instalalce potrebnych balicku
        aptitude install squashfs-tools genisoimage rsync -y
        #pripojeni ISO
	if [ ! -f "${ISO}" ];then
		wget "http://cdimage.ubuntu.com/kubuntu/releases/precise/release/${ISO}" -O ${ISO} || echo "We need Kubuntu ISO..."
	fi
        mount -o loop ${ISO} ${BUILDDIR}/mnt
        #vykopiruje potrebne adresare z ISO
        rsync --exclude=/casper/filesystem.squashfs --exclude=wubi.exe --exclude=preseed --exclude=dists --exclude=pics --exclude=ubuntu --exclude=uutorun.inf --exclude=install --exclude=.disk -a ${BUILDDIR}/mnt/ ${BUILDDIR}/extract-cd/
        #rozbaleni
        unsquashfs ${BUILDDIR}/mnt/casper/filesystem.squashfs
        #vytvoreni working directory
        mv squashfs-root ${BUILDDIR}/edit
        #nastaveni site a pripojeni dev do chrootu
        cp /etc/resolv.conf ${BUILDDIR}/edit/etc/
        ####DELETE one
#       grep dns-nameservers /etc/network/interfaces |awk '{print $2}' > ${BUILDDIR}/edit/etc/resolv.conf
        mount --bind /dev/ ${BUILDDIR}/edit/dev
        echo "Entering chroot"
#       chroot ${BUILDDIR}/edit
        ####testing
        #edit sources list
        echo "deb http://cs.archive.ubuntu.com/ubuntu/ ${UBUVERSION} main restricted universe multiverse" > ${BUILDDIR}/edit/etc/apt/sources.list
        echo "deb http://cs.archive.ubuntu.com/ubuntu/ ${UBUVERSION}-security main restricted universe multiverse" >> ${BUILDDIR}/edit/etc/apt/sources.list
        echo "deb http://cs.archive.ubuntu.com/ubuntu/ ${UBUVERSION}-updates main restricted universe multiverse" >> ${BUILDDIR}/edit/etc/apt/sources.list
        echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> ${BUILDDIR}/edit/etc/apt/sources.list
        wget -q -O ${BUILDDIR}/edit/tmp/linux_signing_key.pub https://dl-ssl.google.com/linux/linux_signing_key.pub
        #delete apt configuration
        rm -f ${BUILDDIR}/edit/etc/apt/apt.conf.d/10periodic
        rm -f ${BUILDDIR}/edit/etc/apt/apt.conf.d/15update-stamp
        rm -f ${BUILDDIR}/edit/etc/apt/apt.conf.d/20archive
        rm -f ${BUILDDIR}/edit/etc/apt/apt.conf.d/20changelog
        rm -f ${BUILDDIR}/edit/etc/apt/apt.conf.d/50unattended-upgrades
        rm -f ${BUILDDIR}/edit/etc/apt/apt.conf.d/99update-notifier
        #go chrooting :-D
        chroot ${BUILDDIR}/edit mount -t proc none /proc
        chroot ${BUILDDIR}/edit mount -t sysfs none /sys
        chroot ${BUILDDIR}/edit mount -t devpts none /dev/pts
        chroot ${BUILDDIR}/edit apt-key add /tmp/linux_signing_key.pub
        rm -f ${BUILDDIR}/edit/tmp/linux_signing_key.pub
        chroot ${BUILDDIR}/edit locale-gen cs_CZ.UTF-8
        chroot ${BUILDDIR}/edit apt-get update
        chroot ${BUILDDIR}/edit apt-get install aptitude -y
        chroot ${BUILDDIR}/edit aptitude purge -y thunderbird ubuntuone-client banshee shotwell software-center unity-lens-music unity-scope-musicstores banshee-extension-soundmenu libsyncdaemon-1.0-1 ubuntu-desktop ubuntuone-client-gnome ubuntuone-control-panel ubuntuone-control-panel-gtk python-ubuntuone-client  ubiquity-slideshow-ubuntu ubiquity-ubuntu-artwork ubuntu-sso-client python-ubuntuone-storageprotocol python-ubuntuone-control-panel ubuntuone-installer ubuntuone-couch oneconf
        chroot ${BUILDDIR}/edit aptitude purge -y deja-dup ubiquity gnome-user-guide empathy ubuntu-docs ubiquity-frontend-gtk ubiquity-slideshow-ubuntu gwibber tomboy #grub-common grub-pc grub-pc-bin grub2-common grub-gfxpayload-lists
        chroot ${BUILDDIR}/edit aptitude purge -y gnome-sudoku gnome-mahjongg gnome-games-common gnome-online-accounts gnomine avahi-daemon avahi-utils libnss-mdns telepathy-salut
        chroot ${BUILDDIR}/edit aptitude purge -y aisleriot empathy-common evolution-data-server gbrainy gwibber-service gwibber-service-facebook gwibber-service-identica gwibber-service-twitter libgweather-common nautilus-sendto-empathy update-notifier apport-gtk libgwibber2 libgwibber-gtk2 libgweather-3-0
        chroot ${BUILDDIR}/edit aptitude purge -y apt-clone apt-transport-https apt-utils  ubiquity-slideshow-kubuntu update-manager-core update-manager-kde update-notifier-common  unattended-upgrades ubuntu-minimal python-software-properties python-aptdaemon aptdaemon xul-ext-ubufox
        ###KDE
        chroot ${BUILDDIR}/edit aptitude purge -y dragonplayer amarok kopete muon muon-installer muon-notifier muon-updater akregator rekonq ktorrent quassel bluedevil kmail kaddressbook korganizer ktimetracker usb-creator-kde kontact qapt-deb-installer apturl-kde kubuntu-debug-installer kubuntu-desktop kubuntu-firefox-installer kubuntu-notification-helper language-selector-kde libmuonprivate1 software-properties-kde ktorrent-data amarok-common libkopete4 kopete-message-indicator apport-kde
        #language removal
        chroot ${BUILDDIR}/edit aptitude purge -y language-pack-gnome-es-base language-pack-gnome-de-base language-pack-gnome-pt-base language-pack-pt-base language-pack-gnome-zh-hans-base language-pack-de-base language-pack-zh-hans-base language-pack-gnome-xh-base language-pack-xh-base language-pack-zh-hans language-pack-xh language-pack-pt language-pack-gnome-zh-hans language-pack-gnome-xh language-pack-gnome-pt language-pack-gnome-es language-pack-gnome-de language-pack-es language-pack-de language-pack-es-base firefox-locale-es firefox-locale-pt firefox-locale-zh-hans firefox-locale-de firefox-locale-en language-pack-en language-pack-en-base
        #czech language
        chroot ${BUILDDIR}/edit aptitude install -y language-pack-cs language-pack-kde-cs firefox-locale-cs firefox
        #new installations
        chroot ${BUILDDIR}/edit aptitude install -y p7zip-full htop mc google-chrome-beta vlc flashplugin-installer icedtea-7-plugin
 
 
        #test
######  chroot ${BUILDDIR}/edit aptitude -o Dpkg::Options::="--force-confnew" -fy full-upgrade
        #delete old kernels
        #chroot ${BUILDDIR}/edit aptitude purge `dpkg --get-selections|grep linux-image-[0-9]|sort -r|awk '{print $1}'|tail -n +2` -y
        #chroot ${BUILDDIR}/edit aptitude clean
        #chroot ${BUILDDIR}/edit usermod -u 500 `awk -F: '{ if ($3 > 999) print $1 }' /etc/passwd`
fi
 
##part 2
if [ "$1" = "part2" ];then
 
###KDE PART
        cp ${FILESKDE}/00-defaultLayout.js ${BUILDDIR}/edit/usr/share/kubuntu-default-settings/kde4-profile/default/share/apps/plasma-desktop/init/00-defaultLayout.js
        cp ${FILESKDE}/layout.js ${BUILDDIR}/edit/usr/share/kde4/apps/plasma/layout-templates/org.kde.plasma-desktop.defaultPanel/contents/layout.js
        rm ${BUILDDIR}/edit/usr/share/kubuntu-default-settings/kde4-profile/default/share/config/*
        cp ${FILESKDE}/share_config/* ${BUILDDIR}/edit/usr/share/kubuntu-default-settings/kde4-profile/default/share/config/
        rm ${BUILDDIR}/edit/usr/share/kde4/apps/plasma-desktop/updates/addShowActivitiesManagerPlasmoid.js
###KDE PART END
 
        echo "update initrams po editaci isolinux"
        echo "Uprav cokoli v chrootu"
        echo "chroot ${BUILDDIR}/edit"
fi
 
 
## part 3
if [ "$1" = "part3" ];then
        chroot ${BUILDDIR}/edit aptitude clean
        chroot ${BUILDDIR}/edit aptitude autoclean
        rm ${BUILDDIR}/edit/etc/apt/sources.list.d/*
        rm ${BUILDDIR}/edit/etc/apt/sources.list
        ###remove halt message about pressing enter
        rm ${BUILDDIR}/edit/etc/rc6.d/*casper
        rm ${BUILDDIR}/edit/etc/rc0.d/*casper
        ###remove tty's job to be able to poweroff livecd
        rm ${BUILDDIR}/edit/etc/init/tty1.conf
        rm ${BUILDDIR}/edit/etc/init/tty2.conf
        rm ${BUILDDIR}/edit/etc/init/tty3.conf
        rm ${BUILDDIR}/edit/etc/init/tty4.conf
        rm ${BUILDDIR}/edit/etc/init/tty5.conf
        rm ${BUILDDIR}/edit/etc/init/tty6.conf
 
        umount -l ${BUILDDIR}/edit/proc
        umount -l ${BUILDDIR}/edit/dev/pts
        umount -l ${BUILDDIR}/edit/dev
        umount -l ${BUILDDIR}/edit/sys
###change boot
        rm ${BUILDDIR}/extract-cd/isolinux/*
        cp ${FILES}/boot/* ${BUILDDIR}/extract-cd/isolinux/
###change boot end
 
###remove unnecessary files!
        rm -fr ${BUILDDIR}/usr/share/doc/
        rm -fr ${BUILDDIR}/usr/share/doc-base/
        rm ${BUILDDIR}/edit/etc/resolv.conf
 
        chmod +w ${BUILDDIR}/extract-cd/casper/filesystem.manifest
        chroot ${BUILDDIR}/edit dpkg-query -W --showformat='${Package} ${Version}\n' > ${BUILDDIR}/extract-cd/casper/filesystem.manifest
        cp ${BUILDDIR}/extract-cd/casper/filesystem.manifest ${BUILDDIR}/extract-cd/casper/filesystem.manifest-desktop
        sed -i '/ubiquity/d' ${BUILDDIR}/extract-cd/casper/filesystem.manifest-desktop
        sed -i '/casper/d' ${BUILDDIR}/extract-cd/casper/filesystem.manifest-desktop
        #rm ${BUILDDIR}/extract-cd/casper/filesystem.squashfs
        mksquashfs ${BUILDDIR}/edit ${BUILDDIR}/extract-cd/casper/filesystem.squashfs -noappend
        printf $(du -sx --block-size=1 ${BUILDDIR}/edit | cut -f1) > ${BUILDDIR}/extract-cd/casper/filesystem.size
 
        #vim extract-cd/README.diskdefines
        if [ -f ${BUILDDIR}/extract-cd/md5sum.txt ];then
      rm ${BUILDDIR}/extract-cd/md5sum.txt
        fi
        find ${BUILDDIR}/extract-cd -type f -print0 | xargs -0 md5sum | grep -v isolinux/boot.cat | tee ${BUILDDIR}/extract-cd/md5sum.txt
        cd ${BUILDDIR}/extract-cd/
        mkisofs -D -r -V "$IMAGE_NAME" -cache-inodes -J -joliet-long -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../custom.iso .
        isohybrid ${BUILDDIR}/custom.iso
        echo "virsh stop livecd; virsh start livecd"
        echo "Vytvoreni USB bootable disku staci pouzit prikaz:"
        echo "dd if=${BUILDDIR}/custom.iso of=/dev/sd[X]"
 
fi
 
if [ "$1" = "clean" ];then
        umount -l ${BUILDDIR}/mnt
        umount -l ${BUILDDIR}/edit/proc
        umount -l ${BUILDDIR}/edit/dev/pts
        umount -l ${BUILDDIR}/edit/dev
        umount -l ${BUILDDIR}/edit/sys
        rm -rf ${BUILDDIR}/edit
        rm -rf ${BUILDDIR}/extract-cd/
        rmdir ${BUILDDIR}/mnt
fi
#kvm -cdrom ubuntu-9.04.1-desktop-i386-custom.iso -boot d -m 512