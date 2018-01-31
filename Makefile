shell=/bin/bash

#
# Global proj. directory paths
#
# -- rpm spec file expects this path to be available
#
export PROJDIR=$(shell pwd)


#
# RPM build related defines
#

RPMNAME=vrf

RPMCMD=/usr/bin/rpmbuild -bb --define '_topdir $(PROJDIR)/rpmbuild' \
       --define '_tmppath $(PROJDIR)/rpmbuild/tmp'

.PHONY: rpm

default:
	@echo "Nothing to build"

deb:
	dpkg-buildpackage -uc -us

rpm:
	@ echo "=======Building $(RPMNAME) RPM=======" ; \
	$(RPMCMD) -bb rpm/$(RPMNAME).spec && \
	echo "=======$(PROJDIR): make rpm is done======="
	@mv $(PROJDIR)/rpmbuild/RPMS/x86_64/vrf-*.*.rpm .

install:
	install -D -m 755 bin/vrf              $(DESTDIR)/usr/bin/vrf
	install -D -m 755 lib-vrf/vrf-helper   $(DESTDIR)/usr/lib/vrf/vrf-helper
	install -D -m 644 etc/profile.d/vrf.sh $(DESTDIR)/etc/profile.d/vrf.sh
	install -D -m 644 etc/vrf/systemd.conf $(DESTDIR)/etc/vrf/systemd.conf
	install -D -m 755 systemd/systemd-vrf-generator      $(DESTDIR)/lib/systemd/system-generators/systemd-vrf-generator
	install -D -m 755 etc/dhcp/dhclient-exit-hooks.d/vrf $(DESTDIR)/etc/dhcp/dhclient-exit-hooks.d/vrf
	install -D -m 644 ifupdown2/policy.d/vrf.json    $(DESTDIR)/var/lib/ifupdown2/policy.d/vrf.json

uninstall:
	rm -f $(DESTDIR)/usr/bin/vrf
	rm -f $(DESTDIR)/usr/lib/vrf/vrf-helper
	rm -f $(DESTDIR)/etc/profile.d/vrf.sh
	rm -f $(DESTDIR)/etc/vrf/systemd.conf
	rm -f $(DESTDIR)/lib/systemd/system-generators/systemd-vrf-generator
	rm -f $(DESTDIR)/etc/dhcp/dhclient-exit-hooks.d/vrf
	rm -f $(DESTDIR)/var/lib/ifupdown2/policy.d/vrf.json

help:
	@echo 'Targets:'
	@echo '  install		- Install files in current filesystem.'
	@echo '         		  Path prefix can be set via DESTDIR'
	@echo '  uninstall		- Remove files from current filesystem'
	@echo '         		  Path prefix can be set via DESTDIR'
	@echo ''
	@echo '  rpm    		- Create an rpm package that can be installed'
	@echo '  deb    		- Create an debian package that can be installed'
	@echo ''
