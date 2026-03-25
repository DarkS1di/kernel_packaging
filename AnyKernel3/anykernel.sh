### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=Electro Kernel by NoxS1d
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=citrus
device.name2=lime
device.name3=lemon
device.name4=pomelo
device.name5=chime
device.name6=juice
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

SYS_NAMES="$(getprop ro.product.device) $(getprop ro.build.product) $(getprop ro.product.vendor.device) $(getprop ro.vendor.product.device)"

case " $SYS_NAMES " in
  *" citrus "*)
    mv citrus/dtbo.img dtbo.img ;;
  *" lime "* | *" lemon "* | *" pomelo "*)
    mv lime/dtbo.img dtbo.img ;;
  *)
    rm -f dtb ;;
esac

# boot install
split_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

flash_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk

if [ -f "dtbo.img" ]; then
    flash_dtbo;
fi
## end boot install

