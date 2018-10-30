#
# Copyright 2017 Cumulus Networks, Inc. All rights reserved.
#
# Author: David Ahern, dsa@cumulusnetworks.com

CFLAGS = -Wall -I/usr/include/libnl3
LIBS = -lnl-route-3 -lnl-3
CC=gcc

vrf-dns-helper: vrf-dns-helper.o
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -f vrf-dns-helper vrf-dns-helper.o

distclean: clean
