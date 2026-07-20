#!/usr/bin/env bash
# controls/1.1.2.2.4_noexec_option_set_on_dev_shm_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.2.4"
    local TITLE="Ensure noexec option set on /dev/shm partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /dev/shm, verify that the noexec option is set.
# findmnt -kn /dev/shm | grep -v 'noexec'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The noexec mount option specifies that the filesystem cannot contain executable
binaries.

Rationale:
Setting this option on a file system prevents users from executing programs from shared
memory. This deters users from introducing potentially malicious software on the
system."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /dev/shm.
Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the
/dev/shm partition.
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
        CURRENT="/dev/shm is not mounted, so noexec check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/dev/shm" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnoexec\b"; then
            CURRENT="/dev/shm is mounted with noexec option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/dev/shm is mounted but missing noexec option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
