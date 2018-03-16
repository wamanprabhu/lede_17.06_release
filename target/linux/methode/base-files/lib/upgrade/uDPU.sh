ubi_change_root() {
	TMP_ROOT=/tmp/new_root
	mkdir -p $TMP_ROOT
	mount -t tmpfs none $TMP_ROOT

	cd /
	MOVE_DIRS="bin dev etc lib sbin usr"
	for CURR_DIR in $MOVE_DIRS; do
		cp -a $CURR_DIR $TMP_ROOT
	done

	mkdir $TMP_ROOT/proc
	mkdir $TMP_ROOT/oldroot

	mount --bind /proc $TMP_ROOT/proc

	cd $TMP_ROOT
	/sbin/pivot_root . oldroot
	cd /

	echo "::restart:/sysupgrade" >> /etc/inittab 
	echo "umount /oldroot" >> /sysupgrade
}

prep_ubi_part() {
	ubi_change_root

	[ -d "oldroot" ] && cd oldroot
	rm -rf *
	tar -xvzf $ARGV -C .
	sync
}
