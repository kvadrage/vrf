#!/bin/sh

# export VRF symbol noting which VRF the process was started in
# export get_vrf function and PS1 for setting prompt.
#
# default task to management VRF if task is not running in a
# VRF context

function get_vrf
{
	local vrf=$(/usr/cumulus/bin/cl-vrf.sh task show pid $$)
	[ -n "$vrf" ] && echo "[$vrf]"
}

/usr/cumulus/bin/cl-vrf.sh exists mmgt
if [ $? -eq 0 ]; then
	VRF=$(get_vrf)
	if [ -z "$VRF" ]; then
		/usr/cumulus/bin/cl-vrf.sh task move mgmt $$
	fi
fi
export VRF=$(get_vrf)

PS1="$(get_vrf)\u@\h:\w\$ "
