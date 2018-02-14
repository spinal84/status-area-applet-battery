all: status-area-applet-battery.so

# /usr/bin/ld: relocation R_X86_64_PC32 against symbol `stderr@@GLIBC_2.2.5'
# can not be used when making a shared object; recompile with -fPIC
CFLAGS += -fPIC

install:
	install -d "$(DESTDIR)/usr/lib/hildon-desktop/"
	install -d "$(DESTDIR)/usr/share/applications/hildon-status-menu/"
	install -d "$(DESTDIR)/usr/share/gconf/schemas/"
	install -m 644 status-area-applet-battery.so "$(DESTDIR)/usr/lib/hildon-desktop/"
	install -m 644 status-area-applet-battery.desktop "$(DESTDIR)/usr/share/applications/hildon-status-menu/"
	install -m 644 status-area-applet-battery.schemas "$(DESTDIR)/usr/share/gconf/schemas/"

clean:
	$(RM) status-area-applet-battery.so

status-area-applet-battery.so: status-area-applet-battery.c batmon.c batmon.h upower-defs.h
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $(shell pkg-config --cflags --libs hildon-1 libcanberra profile libhildondesktop-1 dbus-1 gconf-2.0) -W -Wall -O2 -shared $^ -o $@

.PHONY: all install clean
