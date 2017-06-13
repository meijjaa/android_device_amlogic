# Copyright (C) 2011 Amlogic Inc
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
# This file is the build configuration for a full Android
# build for Meson reference board.
#

# Dynamic enable start/stop zygote_secondary in 64bits
# and 32bit system, default closed
TARGET_DYNAMIC_ZYGOTE_SECONDARY_ENABLE := false
# Inherit from those products. Most specific first.

#ifneq ($(ANDROID_BUILD_TYPE), 32)
#ifeq ($(TARGET_DYNAMIC_ZYGOTE_SECONDARY_ENABLE), true)
#$(call inherit-product, device/amlogic/common/dynamic_zygote_seondary/dynamic_zygote_64_bit.mk)
#else
#$(call inherit-product, build/target/product/core_64_bit.mk)
#endif
#endif
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/amlogic/common/core_amlogic.mk)
$(call inherit-product, device/amlogic/s912/product/product.mk)
$(call inherit-product,  device/amlogic/common/software.mk)
$(call inherit-product, device/amlogic/s912/device_s912.mk)

# OpenGapps
GAPPS_VARIANT := pico
$(call inherit-product,vendor/google/build/opengapps-packages.mk)

PRODUCT_PROPERTY_OVERRIDES += \
        sys.fb.bits=32 \
        ro.hdmi.device_type=4 \
        persist.sys.hdmi.keep_awake=false

WITH_LIBPLAYER_MODULE := true

PRODUCT_COPY_FILES += \
    device/amlogic/s912/fstab.amlogic:root/fstab.amlogic

#########################################################################
#
#                                                WiFi
#
#########################################################################

#MULTI_WIFI_SUPPORT := true
#include device/amlogic/common/wifi.mk

# Change this to match target country
# 11 North America; 14 Japan; 13 rest of world
#PRODUCT_DEFAULT_WIFI_CHANNELS := 11

# Wifi

WIFI_DRIVER := bcm4335
BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_MODULE_NAME := dhd
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/dhd.ko"

BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
WPA_SUPPLICANT_VERSION := VER_0_8_X

WIFI_DRIVER_MODULE_ARG      := "firmware_path=/system/vendor/firmware/fw_bcm4335b0_ag.bin nvram_path=/system/vendor/firmware/nvram_bcm4335.txt"
WIFI_DRIVER_MODULE_AP_ARG   := "firmware_path=/system/vendor/firmware/fw_bcm4335b0_ag_apsta.bin nvram_path=/system/vendor/firmware/nvram_bcm4335.txt"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/system/vendor/firmware/fw_bcm4335b0_ag.bin"
WIFI_DRIVER_FW_PATH_AP      := "/system/vendor/firmware/fw_bcm4335b0_ag_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P     := "/system/vendor/firmware/fw_bcm4335b0_ag_p2p.bin"

#WIFI_BAND := 802_11_ABG
WIFI_BUS := sdio

PRODUCT_PACKAGES += \
	wl \
	dhd

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	device/amlogic/common/init.amlogic.wifi_bcm.rc:root/init.amlogic.wifi.rc \
	device/amlogic/s912/wifi/nvram_bcm4335.txt:/system/vendor/firmware/nvram_bcm4335.txt \
	device/amlogic/s912/wifi/fw_bcm4335b0_ag.bin:/system/vendor/firmware/fw_bcm4335b0_ag.bin \
	device/amlogic/s912/wifi/fw_bcm4335b0_ag_apsta.bin:/system/vendor/firmware/fw_bcm4335b0_ag_apsta.bin \
	device/amlogic/s912/wifi/fw_bcm4335b0_ag_p2p.bin:/system/vendor/firmware/fw_bcm4335b0_ag_p2p.bin \
    device/amlogic/s912/wifi/config.txt:/system/vendor/firmware/config.txt \
    device/amlogic/s912/wifi/p2p_supplicant_overlay.conf:/system/etc/wifi/p2p_supplicant_overlay.conf \
    device/amlogic/s912/wifi/wpa_supplicant.conf:/system/etc/wifi/wpa_supplicant.conf \

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	ro.carrier=wifi-only

#########################################################################
#
#                                                Bluetooth
#
#########################################################################

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BCM_BLUETOOTH_LPM_ENABLE := true
BOARD_BLUEDROID_VENDOR_CONF := device/amlogic/s912/bluetooth/vnd_s912.txt

PRODUCT_PACKAGES += \
    libbt-vendor

PRODUCT_PACKAGES += Bluetooth \
    bt_vendor.conf \
    bt_stack.conf \
    bt_did.conf \
    auto_pair_devlist.conf \
    libbt-hci \
    bluetooth.default \
    audio.a2dp.default \
    libbt-client-api \
    com.broadcom.bt \
    com.broadcom.bt.xml
    
PRODUCT_COPY_FILES += \
    hardware/amlogic/libbt/data/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    hardware/amlogic/libbt/data/blacklist.conf:system/etc/bluetooth/blacklist.conf
    
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml
    
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/amlogic/s912/bluetooth

PRODUCT_COPY_FILES += device/amlogic/s912/bluetooth/4335/bcm4335.hcd:system/etc/bluetooth/BCM4335.hcd


#########################################################################
#
#                                                ConsumerIr
#
#########################################################################

#PRODUCT_PACKAGES += \
#    consumerir.amlogic \
#    SmartRemote
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

ifeq ($(SUPPORT_HDMIIN),true)
PRODUCT_PACKAGES += \
    libhdmiin \
    HdmiIn
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Audio
#
BOARD_ALSA_AUDIO=tiny
include device/amlogic/common/audio.mk

#########################################################################
#
#                                                Camera
#
#########################################################################

#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml



#########################################################################
#
#                                                PlayReady DRM
#
#########################################################################
#export BOARD_PLAYREADY_LEVEL=3 for PlayReady+NOTVP
#export BOARD_PLAYREADY_LEVEL=1 for PlayReady+OPTEE+TVP
#########################################################################
#
#                                                Verimatrix DRM
##########################################################################
#verimatrix web
BUILD_WITH_VIEWRIGHT_WEB := false
#verimatrix stb
BUILD_WITH_VIEWRIGHT_STB := false
#########################################################################


#DRM Widevine
ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL),)
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
endif

ifeq ($(BOARD_WIDEVINE_OEMCRYPTO_LEVEL), 1)
TARGET_USE_OPTEEOS := true
endif

$(call inherit-product, device/amlogic/common/media.mk)

#########################################################################
#
#                                                Languages
#
#########################################################################

$(call inherit-product, build/target/product/languages_full.mk)

#################################################################################
#
#                                                DEFAULT LOWMEMORYKILLER CONFIG
#
#################################################################################
BUILD_WITH_LOWMEM_COMMON_CONFIG := true

BOARD_USES_USB_PM := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/Third_party_apk_camera.xml:system/etc/Third_party_apk_camera.xml \

BUILD_WITH_TIMER_POWER_CONFIG :=true

PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=240
