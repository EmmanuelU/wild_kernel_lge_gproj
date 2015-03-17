#!/sbin/sh
/tmp/unpackbootimg -i /tmp/boot.img -o /tmp/
mkdir /tmp/ramdisk/
mv -f /tmp/boot.img-ramdisk.gz /tmp/ramdisk/boot.img-ramdisk.gz
cd /tmp/ramdisk
gunzip -c boot.img-ramdisk.gz | cpio -i
rm -rf boot.img-ramdisk.gz
cp -arf /tmp/ramdisk_override/* /tmp/ramdisk
find . | cpio -o -H newc | gzip > /tmp/boot.img-ramdisk.gz
cd ../..

echo \#!/sbin/sh > /tmp/createnewboot.sh
echo /tmp/mkbootimg --kernel /tmp/zImage --ramdisk /tmp/boot.img-ramdisk.gz --cmdline \"$(cat /tmp/boot.img-cmdline)\" --base 0x80200000 --ramdisk_offset 0x02000000 --output /tmp/newboot.img >> /tmp/createnewboot.sh
chmod 777 /tmp/createnewboot.sh
/tmp/createnewboot.sh
rm -rf /sdcard/WildKernel-boot.img
cp /tmp/newboot.img /sdcard/WildKernel-boot.img
return $?
