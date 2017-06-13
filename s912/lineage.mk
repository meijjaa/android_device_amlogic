# Release name
PRODUCT_RELEASE_NAME := s912
ANDROID_BUILD_TYPE := 64
# Inherit some common CM stuff.
WITH_SU := true
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/amlogic/s912/s912.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := s912
PRODUCT_NAME := lineage_s912
PRODUCT_BRAND := amlogic
PRODUCT_MODEL := s912
PRODUCT_MANUFACTURER := amlogic
