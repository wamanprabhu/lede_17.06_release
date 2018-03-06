#
# Copyright (C) 2018 OpenWrt.org
#

# Dummy platform script, letting any image to be used for sysupgrade

platform_check_image() {
	echo -n
}

platform_do_upgrade() {
	local board="random"

	case "$board" in
		*)
			default_do_upgrade "$ARGV"
		;;
	esac
}
