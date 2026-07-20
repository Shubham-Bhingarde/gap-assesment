#!/usr/bin/env bash
# controls/1.1.2.5.2_nodev_option_set_on_var_tmp_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.5.2"
    local TITLE="Ensure nodev option set on /var/tmp partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /var/tmp, verify that the nodev option is set.
Run the following command to verify that the nodev mount option is set.
Example:
# findmnt -kn /var/tmp | grep -v nodev
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nodev mount option specifies that the filesystem cannot contain special devices.

Rationale:
Since the /var/tmp filesystem is not intended to support devices, set this option to
ensure that users cannot create a block or character special devices in /var/tmp."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /var/tmp.
Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the
/var/tmp partition.
Example:
<device> /var/tmp
0
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0
Run the following command to remount /var/tmp with the configured options:
# mount -o remount /var/tmp"

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/var/tmp" 2>/dev/null)
    if [ -z "$MOUNT_CHECK" ]; then
        CURRENT="/var/tmp is not mounted, so nodev check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/var/tmp" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnodev\b"; then
            CURRENT="/var/tmp is mounted with nodev option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/var/tmp is mounted but missing nodev option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
