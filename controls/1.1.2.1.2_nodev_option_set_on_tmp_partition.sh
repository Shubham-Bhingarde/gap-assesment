#!/usr/bin/env bash
# controls/1.1.2.1.2_nodev_option_set_on_tmp_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.1.2"
    local TITLE="Ensure nodev option set on /tmp partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /tmp, verify that the nodev option is set.
Run the following command to verify that the nodev mount option is set.
Example:
# findmnt -kn /tmp | grep -v nodev
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nodev mount option specifies that the filesystem cannot contain special devices.

Rationale:
Since the /tmp filesystem is not intended to support devices, set this option to ensure
that users cannot create a block or character special devices in /tmp."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /tmp.
Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the
/tmp partition.
Example:
<device> /tmp
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0 0
Run the following command to remount /tmp with the configured options:
# mount -o remount /tmp"

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/tmp" 2>/dev/null)
    if [ -z "$MOUNT_CHECK" ]; then
        CURRENT="/tmp is not mounted, so nodev check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/tmp" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnodev\b"; then
            CURRENT="/tmp is mounted with nodev option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/tmp is mounted but missing nodev option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
