#!/usr/bin/env bash

vrf=$(/usr/cumulus/bin/cl-vrf id)

# if we are not in mgmt VRF then run the command as given
# in whatever VRF context we are in

if [ "$vrf" != "mgmt" ]; then
	exec /bin/ping.iputils-ping $*
fi

# we are in the mgmt VRF context. is -I eth0 given? if so
# the user wants a ping in this context. nothing to do.

echo "$*" | egrep -q -- '-I.*eth0|-I.*mgmt'
if [ $? -eq 0 ]; then
	exec /bin/ping.iputils-ping $*
fi

# this means we are in mgmt VRF and -I eth0 was not given.
# Want ping to default to front panel ports using default VRF

/usr/cumulus/bin/cl-vrf task set default $$
exec /bin/ping.iputils-ping $*
