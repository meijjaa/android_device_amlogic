#
# Copyright (C) 2013 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifeq ($(ANDROID_BUILD_TYPE), 32)
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a9
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

else
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a9
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true
endif

TARGET_USES_64_BIT_BINDER := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true
TARGET_NO_RECOVERY := false

TARGET_BOARD_PLATFORM := gxm
TARGET_BOOTLOADER_BOARD_NAME := gxm

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Enable frame-exact AV sync
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.avsync=true

# Camera
USE_CAMERA_STUB := true
BOARD_HAVE_FRONT_CAM := false
BOARD_HAVE_BACK_CAM := false
BOARD_USE_USB_CAMERA := true
IS_CAM_NONBLOCK := true
BOARD_HAVE_FLASHLIGHT := false
BOARD_HAVE_HW_JPEGENC := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13088325632
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

#TARGET_USERIMAGES_USE_EXT4 := true
#BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
#BOARD_BOOTIMAGE_PARTITION_SIZE := 0x000002000000
#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x000002000000
#BOARD_SYSTEMIMAGE_PARTITION_SIZE := 0x000040000000
#BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x00030c200000
#BOARD_CACHEIMAGE_PARTITION_SIZE := 0x000020000000
#BOARD_FLASH_BLOCK_SIZE := 131072
#BOARD_FLASH_BLOCK_SIZE := 4096

BOARD_HAL_STATIC_LIBRARIES := libhealthd.mboxdefault

USE_E2FSPROGS := true

#BOARD_KERNEL_CMDLINE := console=tty0 rootfstype=ramfs init=/init androidboot.selinux=permissive androidboot.hardware=amlogic console=ttyS0,115200 no_console_suspend earlyprintk=aml-uart,0xc81004c0 ramoops.pstore_en=1 ramoops.record_size=0x8000 ramoops.console_size=0x4000 \
#    logo=osd1,loaded,0x3d800000,576cvbs maxcpus=8 vout=576cvbs,enable hdmimode=2160p60hz420 cvbsmode=576cvbs hdmitx= cvbsdrv=0 \
#    androidboot.firstboot=0 jtag=apao \
#    mac=D0:76:58:06:C3:53 androidboot.mac=D0:76:58:06:C3:53

BOARD_KERNEL_PAGESIZE := 2048
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CONFIG := meson64_defconfig
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin

#BOARD_KERNEL_BASE := 0x00000000
BOARD_MKBOOTIMG_ARGS += --kernel_offset 0x1080000
BOARD_KERNEL_BASE := 0x0
#BOARD_KERNEL_OFFSET := 0x1080000

BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true

#TARGET_RECOVERY_DISABLE_ADB_SIDELOAD := true

TARGET_OTA_ASSERT_DEVICE := KM8PRO

TARGET_RECOVERY_FSTAB := device/amlogic/s912/recovery/recovery.fstab

RECOVERY_FSTAB_VERSION := 2
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

RECOVERY_VARIANT := twrp

TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
TARGET_RECOVERY_FORCE_PIXEL_FORMAT := "RGB_565"

TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_BRIGHTNESS_PATH := "/brightness"
TW_THEME := landscape_hdpi
TW_ROUND_SCREEN := true
TW_INCLUDE_CRYPTO := true
TW_NO_BATT_PERCENT := true
TW_NO_SCREEN_TIMEOUT := true
TWHAVE_SELINUX := true
TW_INCLUDE_FB2PNG := true
TW_INCLUDE_NTFS_3G := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
RECOVERY_SDCARD_ON_DATA := true
TW_NO_REBOOT_BOOTLOADER := true

include device/amlogic/common/sepolicy.mk
include device/amlogic/common/gpu/t82x-user-$(TARGET_ARCH).mk
#MALLOC_IMPL := dlmalloc
