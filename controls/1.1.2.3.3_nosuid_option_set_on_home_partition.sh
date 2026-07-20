#!/usr/bin/env bash
# controls/1.1.2.3.3_nosuid_option_set_on_home_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.3.3"
    local TITLE="Ensure nosuid option set on /home partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /home, verify that the nosuid option is set.
Run the following command to verify that the nosuid mount option is set.
Example:
# findmnt -kn /home | grep -v nosuid
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nosuid mount option specifies that the filesystem cannot contain setuid files.

Rationale:
Since the /home filesystem is only intended for user file storage, set this option to
ensure that users cannot create setuid files in /home."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /home.
Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the
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
        CURRENT="/home is not mounted, so nosuid check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/home" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnosuid\b"; then
            CURRENT="/home is mounted with nosuid option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/home is mounted but missing nosuid option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
