ARCH = armv6

GCCVER = 4.2.1
SDKVER = 3.0

SDK = /Developer/Platforms/iPhoneOS.platform/Developer
SYSROOT = $(SDK)/SDKs/iPhoneOS$(SDKVER).sdk

CC = $(SDK)/usr/bin/arm-apple-darwin9-gcc-$(GCCVER)
CPP = $(SDK)/usr/bin/arm-apple-darwin9-g++-$(GCCVER)
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

CFLAGS += -I"$(SDK)/usr/lib/gcc/arm-apple-darwin9/$(GCCVER)/include"
CFLAGS += -I"$(SYSROOT)/usr/include"
CFLAGS += -I"$(SDK)/usr/include"
CFLAGS += -F"$(SYSROOT)/System/Library/Frameworks"
CFLAGS += -F"$(SYSROOT)/System/Library/PrivateFrameworks"
CFLAGS += -DDEBUG -std=c99
CFLAGS += -Diphoneos_version_min=2.2
CFLAGS += -dynamiclib
CFLAGS += -march=$(ARCH)
CFLAGS += -mcpu=arm1176jzf-s

CPPFLAGS = $(CFLAGS)
CPPFLAGS += -fobjc-call-cxx-cdtors 

TARGET = Toggle.dylib

all: $(TARGET)

$(TARGET): MailFetchToggle.o
	$(LD) $(LDFLAGS) -o $@ $^
	ldid -S $(TARGET)

%.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@
	   
%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f *.o $(TARGET)
