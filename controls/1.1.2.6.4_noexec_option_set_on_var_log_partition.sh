#!/usr/bin/env bash
# controls/1.1.2.6.4_noexec_option_set_on_var_log_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.6.4"
    local TITLE="Ensure noexec option set on /var/log partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /var/log, verify that the noexec option is set.
Run the following command to verify that the noexec mount option is set.
Example:
# findmnt -kn /var/log | grep -v noexec
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The noexec mount option specifies that the filesystem cannot contain executable
binaries.

Rationale:
Since the /var/log filesystem is only intended for log files, set this option to ensure
that users cannot run executable binaries from /var/log."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /var/log.
Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the
/var/log partition.
Example:
<device> /var/log
0
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0
Run the following command to remount /var/log with the configured options:
# mount -o remount /var/log"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
