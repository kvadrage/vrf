# default task to management VRF if it exists and task is not running
# in a VRF context
[ -n "$VRF" ] && exit 0

/usr/cumulus/bin/cl-vrf mgmt status >/dev/null 2>&1
if [ $? -eq 0 ]; then
	VRF=$(/usr/cumulus/bin/cl-vrf identify prompt)
	if [ -z "$VRF" ]; then
		sudo /usr/cumulus/bin/cl-vrf mgmt set $$
	fi
fi

VRF=$(/usr/cumulus/bin/cl-vrf identify)
export VRF

PS1='$(/usr/cumulus/bin/cl-vrf identify prompt)\u@\h:\w\$ '
