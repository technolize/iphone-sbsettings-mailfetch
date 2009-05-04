ARCH = armv6

SDKVER = 2.2
SDK = /Developer/Platforms/iPhoneOS.platform/Developer
SYSROOT = $(SDK)/SDKs/iPhoneOS$(SDKVER).sdk

CC = $(SDK)/usr/bin/arm-apple-darwin9-gcc-4.0.1
CPP = $(SDK)/usr/bin/arm-apple-darwin9-g++-4.01
LD = $(CC)

LDFLAGS += -framework CoreFoundation
LDFLAGS += -framework Foundation

LDFLAGS += -L"$(SDK)/usr/lib"
LDFLAGS += -F"$(SDK)/System/Library/Frameworks"
LDFLAGS += -F"$(SDK)/System/Library/PrivateFrameworks"

LDFLAGS += -lobjc
LDFLAGS += -dynamiclib
LDFLAGS += -march=$(ARCH)
LDFLAGS += -mcpu=arm1176jzf-s
LDFLAGS += -fobjc-call-cxx-cdtors
LDFLAGS += -isysroot $(SYSROOT)

CFLAGS += -I"$(SDK)/usr/lib/gcc/arm-apple-darwin9/4.0.1/include"
CFLAGS += -I"$(SYSROOT)/usr/include"
CFLAGS += -I"$(SDK)/usr/include"
CFLAGS += -F"$(SYSROOT)/System/Library/Frameworks"
CFLAGS += -F"$(SYSROOT)/System/Library/PrivateFrameworks"

CFLAGS += -DDEBUG -std=c99
CFLAGS += -Diphoneos_version_min=2.2
CFLAGS += -arch $(ARCH)
CFLAGS += -dynamiclib

CPPFLAGS = $(CFLAGS)

TARGET = Toggle.dylib

all: $(TARGET)

$(TARGET): MailFetchToggle.o
	$(LD) $(LDFLAGS) -o $@ $^
	ldid -S $(TARGET)

%.o: %.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o $(TARGET)
