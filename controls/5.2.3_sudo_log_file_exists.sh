#!/usr/bin/env bash
# controls/5.2.3_sudo_log_file_exists.sh

execute_control() {
    local CONTROL_ID="5.2.3"
    local TITLE="Ensure sudo log file exists ((Automated)"
    local EXPECTED="Run the following command to verify that sudo has a custom log file configured:
# grep -rPsi
\"^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\\"|\')?\H+(\\"|\')?(,\h*\H+\h*)*\h*
(#.*)?\$\" /etc/sudoers*
Verify the output matches:
Defaults logfile=\"/var/log/sudo.log\""
    local RISK="Unknown"
    local DESC="sudo can use a custom log file

Rationale:
A sudo log file simplifies auditing of sudo commands"
    local ATTACK="WARNING: Editing the sudo configuration incorrectly can cause sudo to stop
functioning. Always use visudo to modify sudo configuration files."
    local REMEDIATION="Edit the file /etc/sudoers or a file in /etc/sudoers.d/ with visudo -f <PATH TO
FILE> and add the following line:
Defaults
logfile=\"<PATH TO CUSTOM LOG FILE>\"
Example:
Defaults logfile=\"/var/log/sudo.log\"
Notes:
•
•
•
•
sudo will read each file in /etc/sudoers.d, skipping file names that end in ~ or
contain a . character to avoid causing problems with package manager or editor
temporary/backup files.
Files are parsed in sorted lexical order. That is, /etc/sudoers.d/01_first will
be parsed before /etc/sudoers.d/10_second.
Be aware that because the sorting is lexical, not numeric,
/etc/sudoers.d/1_whoops would be loaded after
/etc/sudoers.d/10_second.
Using a consistent number of leading zeroes in the file names can be used to
avoid such problems."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
