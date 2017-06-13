ifeq ($(BOARD_SUPPORT_INSTABOOT), true)

PRODUCT_PROPERTY_OVERRIDES += \
    config.disable_instaboot=false

instaboot_config_file := $(wildcard $(LOCAL_PATH)/instaboot_config.xml)

PRODUCT_COPY_FILES += \
    $(instaboot_config_file):system/etc/instaboot_config.xml

instaboot_rc := $(wildcard $(LOCAL_PATH)/instaboot.rc)
ifeq ($(instaboot_rc),)
instaboot_rc := device/amlogic/common/instaboot.rc
endif

ifneq ($(BOARD_USES_RECOVERY_AS_BOOT), true)
PRODUCT_COPY_FILES += \
    $(instaboot_rc):root/instaboot.rc
else
PRODUCT_COPY_FILES += \
    $(instaboot_rc):recovery/root/instaboot.rc
endif

#WITH_DEXPREOPT := true
#WITH_DEXPREOPT_PIC := true
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.software.picture_in_picture.xml:system/etc/permissions/android.software.picture_in_picture.xml \
    frameworks/native/data/etc/android.software.voice_recognizers.xml:system/etc/permissions/android.software.voice_recognizers.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.amplayer.widevineenable=true

PRODUCT_PACKAGE_OVERLAYS += device/amlogic/common/overlay
DEVICE_PACKAGE_OVERLAYS += device/amlogic/common/overlay

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.app.rotation=middle_port

