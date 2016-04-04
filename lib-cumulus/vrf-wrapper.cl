#!/usr/bin/env bash

# Wrapper to run a command in default VRF if various conditions
# are not met. Assumes original commands are diverted to
# /usr/share/cumulus-vrf.

export PATH=/usr/share/cumulus-vrf/bin:/usr/share/cumulus-vrf/usr/bin:$PATH

CMD="$1"
shift

# get name of management vrf
mgmt=$(/usr/cumulus/bin/cl-vrf mgmt dev)

# get vrf we are running in
vrf=$(/usr/cumulus/bin/cl-vrf id)

# Want all commands to default to front panel ports using default
# VRF and user specifies argument for other VRF context. So if we
# are running in mgmt VRF switch to default VRF and run command.

if [ "$vrf" = "$mgmt" ]; then
	sudo /usr/cumulus/bin/cl-vrf task set default $$
fi

exec $CMD $*
