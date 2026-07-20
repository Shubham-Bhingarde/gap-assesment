#!/usr/bin/env bash
# controls/1.1.2.7.3_nosuid_option_set_on_var_log_audit_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.7.3"
    local TITLE="Ensure nosuid option set on /var/log/audit partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /var/log/audit, verify that the nosuid option is
set.
Run the following command to verify that the nosuid mount option is set.
Example:
# findmnt -kn /var/log/audit | grep -v nosuid
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nosuid mount option specifies that the filesystem cannot contain setuid files.

Rationale:
Since the /var/log/audit filesystem is only intended for variable files such as logs,
set this option to ensure that users cannot create setuid files in /var/log/audit."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /var/log/audit.
Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the
/var/log/audit partition.
Example:
<device> /var/log/audit
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0 0
Run the following command to remount /var/log/audit with the configured options:
# mount -o remount /var/log/audit"

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/var/log/audit" 2>/dev/null)
    if [ -z "$MOUNT_CHECK" ]; then
        CURRENT="/var/log/audit is not mounted, so nosuid check is not applicable (fail by default or handle upstream)."
        RESULT="FAIL"
    else
        local OPTIONS=$(findmnt -kn -o OPTIONS "/var/log/audit" 2>/dev/null)
        if echo "$OPTIONS" | grep -q "\bnosuid\b"; then
            CURRENT="/var/log/audit is mounted with nosuid option ($OPTIONS)."
            RESULT="PASS"
        else
            CURRENT="/var/log/audit is mounted but missing nosuid option ($OPTIONS)."
            RESULT="FAIL"
        fi
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
