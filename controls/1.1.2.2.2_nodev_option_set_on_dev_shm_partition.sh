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

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
