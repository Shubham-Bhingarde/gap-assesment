#!/usr/bin/env bash
# controls/1.1.2.5.3_nosuid_option_set_on_var_tmp_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.5.3"
    local TITLE="Ensure nosuid option set on /var/tmp partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /var/tmp, verify that the nosuid option is set.
Run the following command to verify that the nosuid mount option is set.
Example:
# findmnt -kn /var/tmp | grep -v nosuid
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nosuid mount option specifies that the filesystem cannot contain setuid files.

Rationale:
Since the /var/tmp filesystem is only intended for temporary file storage, set this option
to ensure that users cannot create setuid files in /var/tmp."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /var/tmp.
Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the
/var/tmp partition.
Example:
<device> /var/tmp
0
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0
Run the following command to remount /var/tmp with the configured options:
# mount -o remount /var/tmp"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
