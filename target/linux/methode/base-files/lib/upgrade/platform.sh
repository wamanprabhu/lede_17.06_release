#
# Copyright (C) 2018 OpenWrt.org
#

platform_check_image() {
	return 0
}

platform_do_upgrade() {
	case "$board" in
		*)
			prep_ubi_part "$ARGV"
		;;
	esac
}
