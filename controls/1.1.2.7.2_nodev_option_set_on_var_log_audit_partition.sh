#!/usr/bin/env bash
# controls/1.1.2.7.2_nodev_option_set_on_var_log_audit_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.7.2"
    local TITLE="Ensure nodev option set on /var/log/audit partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /var/log/audit, verify that the nodev option is set.
Run the following command to verify that the nodev mount option is set.
Example:
# findmnt -kn /var/log/audit | grep -v nodev
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nodev mount option specifies that the filesystem cannot contain special devices.

Rationale:
Since the /var/log/audit filesystem is not intended to support devices, set this option
to ensure that users cannot create a block or character special devices in
/var/log/audit."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /var/log/audit.
Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the
/var/log/audit partition.
Example:
<device> /var/log/audit
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0 0
Run the following command to remount /var/log/audit with the configured options:
# mount -o remount /var/log/audit"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
