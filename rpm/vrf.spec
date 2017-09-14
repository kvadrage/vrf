Summary: Linux tools for VRF
Name: vrf
Version: 1
Release: 1
License: GPL
BuildRoot: %{_tmppath}/%{name}
Vendor: Cumulus Networks
Packager: David Ahern
Requires: iproute

%description
This package provides toos for configuring and using the VRF
 (Virtual Routing and Forwarding) feature in Linux.

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf ${RPM_BUILD_ROOT}
exit 0

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf ${RPM_BUILD_ROOT}

(
cd ${PROJDIR}
make DESTDIR=${RPM_BUILD_ROOT} install
)

(
cd ${RPM_BUILD_ROOT}
find . -type f | sed -e 's,./,/,' | grep -v systemd.conf
) > %{_tmppath}/%{name}.files

%post
/bin/systemctl daemon-reload

%postun
/bin/systemctl daemon-reload

%files -f %{_tmppath}/%{name}.files
%defattr(-,root,root)
%config(noreplace) /etc/vrf/systemd.conf

%changelog
 * Tue Aug 29 2017 20:10:40  David Ahern <dsahern@@gmail.com>
 - initial rpm version
