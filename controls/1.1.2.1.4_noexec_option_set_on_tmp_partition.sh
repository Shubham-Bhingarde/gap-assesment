#!/usr/bin/env bash
# controls/1.1.2.1.4_noexec_option_set_on_tmp_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.1.4"
    local TITLE="Ensure noexec option set on /tmp partition ((Automated)"
    local EXPECTED="- IF - a separate partition exists for /tmp, verify that the noexec option is set.
Run the following command to verify that the noexec mount option is set.
Example:
# findmnt -kn /tmp | grep -v noexec
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The noexec mount option specifies that the filesystem cannot contain executable
binaries.

Rationale:
Since the /tmp filesystem is only intended for temporary file storage, set this option to
ensure that users cannot run executable binaries from /tmp."
    local ATTACK="Setting the noexec option on /tmp may prevent installation and/or updating of some 3rd
party software."
    local REMEDIATION="- IF - a separate partition exists for /tmp.
Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the
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
