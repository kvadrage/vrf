#!/usr/bin/env bash

vrf=$(/usr/cumulus/bin/cl-vrf id)

# if we are not in mgmt VRF then run the command as given
# in whatever VRF context we are in

if [ "$vrf" != "mgmt" ]; then
	exec /usr/bin/traceroute.db -6 $*
fi

# we are in the mgmt VRF context. is -i eth0 given? if so
# the user wants a traceroute in this context. nothing to do.

echo "$*" | egrep -q -- '-i.*eth0|-i.*mgmt'
if [ $? -eq 0 ]; then
	exec /usr/bin/traceroute.db -6 $*
fi

# this means we are in mgmt VRF and -I eth0 was not given.
# Want traceroute to default to front panel ports using default VRF

/usr/cumulus/bin/cl-vrf task set default $$
exec /usr/bin/traceroute.db -6 $*
