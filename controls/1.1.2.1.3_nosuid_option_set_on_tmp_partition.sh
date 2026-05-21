#!/usr/bin/env bash
# controls/1.1.2.1.3_nosuid_option_set_on_tmp_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.1.3"
    local TITLE="Ensure nosuid option set on /tmp partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /tmp, verify that the nosuid option is set.
Run the following command to verify that the nosuid mount option is set.
Example:
# findmnt -kn /tmp | grep -v nosuid
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nosuid mount option specifies that the filesystem cannot contain setuid files.

Rationale:
Since the /tmp filesystem is only intended for temporary file storage, set this option to
ensure that users cannot create setuid files in /tmp."
    local ATTACK=""
    local REMEDIATION="- IF - a separate partition exists for /tmp.
Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the
/tmp partition.
Example:
<device> /tmp
<fstype>
defaults,rw,nosuid,nodev,noexec,relatime
0 0
Run the following command to remount /tmp with the configured options:
# mount -o remount /tmp"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
