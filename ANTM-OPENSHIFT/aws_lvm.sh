#!/bin/sh

dd if=/dev/zero of=/dev/xvdg bs=512 count=1

parted -s /dev/xvdg mklabel gpt \
  mkpart primary ext4 0% 70GB \
  mkpart primary ext4 71GB 100% \
  set 1 lvm \
  set 2 lvm

pvcreate /dev/xvdg1
pvcreate /dev/xvdg2

vgcreate ROOT /dev/xvdg1
vgcreate DOCKER /dev/xvdg2

lvcreate -L 10G -n LV_ETCD ROOT
lvcreate -l 100%free -n LV_ORIGIN ROOT

mkfs.ext4 /dev/ROOT/LV_ETCD
mkfs.ext4 /dev/ROOT/LV_ORIGIN

mkdir -p /var/lib/etcd
mkdir -p /ver/lib/origin

echo "/dev/ROOT/LV_ETCD     /var/lib/etcd                 ext4    defaults        0 0" >> /etc/fstab
echo "/dev/ROOT/LV_ORIGIN   /var/lib/origin               ext4    defaults        0 0" >> /etc/fstab
