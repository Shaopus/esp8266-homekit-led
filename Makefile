PROJECT_NAME = esp8266-homekit-led

CFLAGS += -DHOMEKIT_SHORT_APPLE_UUIDS

include $(IDF_PATH)/make/project.mk
