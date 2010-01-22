LOCAL_PATH := $(call my-dir)

#############################################################
# Build iproute2 library
#

include $(CLEAR_VARS)

# measurements show that the ARM version of ZLib is about x1.17 faster
# than the thumb one...
LOCAL_ARM_MODE := arm

LOCAL_NO_DEFAULT_COMPILER_FLAGS :=true

LOCAL_SRC_FILES := android_port/android_port.c

LOCAL_C_INCLUDES := \
        bionic/libc/arch-arm/include \
        bionic/libc/include \
        bionic/libc/kernel/arch-arm \
        bionic/libc/kernel/common

LOCAL_SHARED_LIBRARIES := \
	libcutils \
	libc

LOCAL_MODULE := libiproute2

include $(BUILD_STATIC_LIBRARY)

#############################################################
# Build Iproute2 netlink library
#

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_NO_DEFAULT_COMPILER_FLAGS :=true

LOCAL_SRC_FILES := \
        iproute2_src/lib/ll_map.c \
        iproute2_src/lib/libnetlink.c

LOCAL_C_INCLUDES := \
        bionic/libc/arch-arm/include \
        bionic/libc/include \
        bionic/libc/kernel/arch-arm \
        $(LOCAL_PATH)/iproute2_src/include \
	bionic/libc/kernel/common

LOCAL_CFLAGS += \
        -fno-exceptions \
        -Wno-multichar \
        -msoft-float -fpic \
        -ffunction-sections \
        -funwind-tables \
        -fstack-protector \
        -fno-short-enums \
        -march=armv5te \
        -mtune=xscale \
        -D__ARM_ARCH_5__ \
        -D__ARM_ARCH_5T__ \
        -D__ARM_ARCH_5E__ \
        -D__ARM_ARCH_5TE__ \
        -include system/core/include/arch/linux-arm/AndroidConfig.h \
        -I system/core/include/arch/linux-arm/ \
        -mthumb-interwork \
        -DANDROID \
        -fmessage-length=0 \
        -W \
        -Wall \
        -Wno-unused \
        -Winit-self \
        -Wpointer-arith \
        -Werror=return-type \
        -Werror=non-virtual-dtor \
        -Werror=address \
        -Werror=sequence-point \
        -DSK_RELEASE \
        -DNDEBUG \
        -g \
        -Wstrict-aliasing=2 \
        -finline-functions \
        -fno-inline-functions-called-once \
        -fgcse-after-reload \
        -frerun-cse-after-loop \
        -frename-registers \
        -DNDEBUG \
        -UDEBUG \
        -O2 \
        -fomit-frame-pointer \
        -fstrict-aliasing \
        -funswitch-loops \
        -finline-limit=300

LOCAL_SHARED_LIBRARIES := libcutils libc
LOCAL_STATIC_LIBRARIES := libiproute2

LOCAL_MODULE := libiproute2netlink

include $(BUILD_STATIC_LIBRARY)

#############################################################
# Build Iproute2 utils library
#

include $(CLEAR_VARS)

# measurements show that the ARM version of ZLib is about x1.17 faster
# than the thumb one...
LOCAL_ARM_MODE := arm

LOCAL_NO_DEFAULT_COMPILER_FLAGS :=true

LOCAL_SRC_FILES := \
        iproute2_src/lib/utils.c \
        iproute2_src/lib/rt_names.c \
        iproute2_src/lib/ll_types.c \
        iproute2_src/lib/ll_proto.c \
        iproute2_src/lib/ll_addr.c \
        iproute2_src/lib/inet_proto.c \
        iproute2_src/lib/dnet_ntop.c \
        iproute2_src/lib/dnet_pton.c \
        iproute2_src/lib/ipx_ntop.c \
        iproute2_src/lib/ipx_pton.c

LOCAL_C_INCLUDES := \
        bionic/libc/arch-arm/include \
        bionic/libc/include \
        bionic/libc/kernel/arch-arm \
        $(LOCAL_PATH)/iproute2_src/include \
        bionic/libc/kernel/common

LOCAL_CFLAGS += \
        -fno-exceptions \
        -Wno-multichar \
        -msoft-float -fpic \
        -ffunction-sections \
        -funwind-tables \
        -fstack-protector \
        -fno-short-enums \
        -march=armv5te \
        -mtune=xscale \
        -D__ARM_ARCH_5__ \
        -D__ARM_ARCH_5T__ \
        -D__ARM_ARCH_5E__ \
        -D__ARM_ARCH_5TE__ \
        -include system/core/include/arch/linux-arm/AndroidConfig.h \
        -I system/core/include/arch/linux-arm/ \
        -mthumb-interwork \
        -DANDROID \
        -fmessage-length=0 \
        -W \
        -Wall \
        -Wno-unused \
        -Winit-self \
        -Wpointer-arith \
        -Werror=return-type \
        -Werror=non-virtual-dtor \
        -Werror=address \
        -Werror=sequence-point \
        -DSK_RELEASE \
        -DNDEBUG \
        -g \
        -Wstrict-aliasing=2 \
        -finline-functions \
        -fno-inline-functions-called-once \
        -fgcse-after-reload \
        -frerun-cse-after-loop \
        -frename-registers \
        -DNDEBUG \
        -UDEBUG \
        -O2 \
        -fomit-frame-pointer \
        -fstrict-aliasing \
        -funswitch-loops \
        -finline-limit=300

LOCAL_SHARED_LIBRARIES := libcutils libc
LOCAL_STATIC_LIBRARIES := libiproute2

LOCAL_MODULE := libiproute2utils

include $(BUILD_STATIC_LIBRARY)

############################################################
# Build Iproute2 'ip' command
#

include $(CLEAR_VARS)

# measurements show that the ARM version of ZLib is about x1.17 faster
# than the thumb one...
LOCAL_ARM_MODE := arm

LOCAL_NO_DEFAULT_COMPILER_FLAGS :=true

LOCAL_SRC_FILES := \
        iproute2_src/ip/ip.c \
        iproute2_src/ip/ipaddress.c \
        iproute2_src/ip/ipaddrlabel.c \
        iproute2_src/ip/iproute.c \
        iproute2_src/ip/iprule.c \
        iproute2_src/ip/rtm_map.c \
        iproute2_src/ip/iptunnel.c \
        iproute2_src/ip/ip6tunnel.c \
        iproute2_src/ip/tunnel.c \
        iproute2_src/ip/ipneigh.c \
        iproute2_src/ip/ipntable.c \
        iproute2_src/ip/iplink.c \
        iproute2_src/ip/ipmaddr.c \
        iproute2_src/ip/ipmonitor.c \
        iproute2_src/ip/ipmroute.c \
        iproute2_src/ip/ipprefix.c \
        iproute2_src/ip/iplink_vlan.c \
        iproute2_src/ip/link_veth.c \
        iproute2_src/ip/link_gre.c \
        iproute2_src/ip/iplink_can.c

LOCAL_C_INCLUDES := \
        bionic/libc/arch-arm/include \
        bionic/libc/include \
        bionic/libc/kernel/arch-arm \
        $(LOCAL_PATH)/iproute2_src/include \
        $(LOCAL_PATH)/android_port \
        bionic/libc/kernel/common \
        kernel/include

LOCAL_CFLAGS+= \
        -fno-exceptions \
        -Wno-multichar \
        -msoft-float -fpic \
        -ffunction-sections \
        -funwind-tables \
        -fstack-protector \
        -fno-short-enums \
        -march=armv5te \
        -mtune=xscale \
        -D__ARM_ARCH_5__ \
        -D__ARM_ARCH_5T__ \
        -D__ARM_ARCH_5E__ \
        -D__ARM_ARCH_5TE__ \
        -include system/core/include/arch/linux-arm/AndroidConfig.h \
        -I system/core/include/arch/linux-arm/ \
        -mthumb-interwork \
        -DANDROID \
        -fmessage-length=0 \
        -W \
        -Wall \
        -Wno-unused \
        -Winit-self \
        -Wpointer-arith \
        -Werror=return-type \
        -Werror=non-virtual-dtor \
        -Werror=address \
        -Werror=sequence-point \
        -DSK_RELEASE \
        -DNDEBUG \
        -g \
        -Wstrict-aliasing=2 \
        -finline-functions \
        -fno-inline-functions-called-once \
        -fgcse-after-reload \
        -frerun-cse-after-loop \
        -frename-registers \
        -DNDEBUG \
        -UDEBUG \
        -O2 \
        -fomit-frame-pointer \
        -fstrict-aliasing \
        -funswitch-loops \
        -finline-limit=300

LOCAL_SHARED_LIBRARIES := \
        libcutils \
        libc

LOCAL_STATIC_LIBRARIES := \
        libiproute2utils \
        libiproute2netlink \
        libiproute2

LOCAL_MODULE := ip

include $(BUILD_EXECUTABLE)
