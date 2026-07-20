#!/usr/bin/env bash
# controls/1.1.2.3.2_nodev_option_set_on_home_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.3.2"
    local TITLE="Ensure nodev option set on /home partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /home, verify that the nodev option is set.
Run the following command to verify that the nodev mount option is set.
Example:
# findmnt -kn /home | grep -v nodev
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nodev mount option specifies that the filesystem cannot contain special devices.

Rationale:
Since the /home filesystem is not intended to support devices, set this option to ensure
that users cannot create a block or character special devices in /home."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /home.
Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the
/home partition.
Example:
<device> /home
<fstype>
defaults,rw,nosuid,nodev,relatime
0 0
Run the following command to remount /home with the configured options:
# mount -o remount /home"

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/home" 2>/dev/null)
    if [ -z "$MOUNT_CHECK" ]; then
        CURRENT="/home is not mounted, so nodev check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/home" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnodev\b"; then
            CURRENT="/home is mounted with nodev option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/home is mounted but missing nodev option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
