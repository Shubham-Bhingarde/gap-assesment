#!/usr/bin/env bash
# controls/1.1.2.2.2_nodev_option_set_on_dev_shm_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.2.2"
    local TITLE="Ensure nodev option set on /dev/shm partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /dev/shm, verify that the nodev option is set.
# findmnt -kn /dev/shm | grep -v 'nodev'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nodev mount option specifies that the filesystem cannot contain special devices.

Rationale:
Since the /dev/shm filesystem is not intended to support devices, set this option to
ensure that users cannot attempt to create special devices in /dev/shm partitions."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /dev/shm.
Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the
/dev/shm partition. See the fstab(5) manual page for more information.
Example:
tmpfs /dev/shm
tmpfs
defaults,rw,nosuid,nodev,noexec,relatime
0 0
Run the following command to remount /dev/shm with the configured options:
# mount -o remount /dev/shm
Note: It is recommended to use tmpfs as the device/filesystem type as /dev/shm is
used as shared memory space by applications."

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/dev/shm" 2>/dev/null)
    if [ -z "$MOUNT_CHECK" ]; then
        CURRENT="/dev/shm is not mounted, so nodev check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/dev/shm" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnodev\b"; then
            CURRENT="/dev/shm is mounted with nodev option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/dev/shm is mounted but missing nodev option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
