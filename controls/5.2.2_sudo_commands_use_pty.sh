#!/usr/bin/env bash
# controls/5.2.2_sudo_commands_use_pty.sh

execute_control() {
    local CONTROL_ID="5.2.2"
    local TITLE="Ensure sudo commands use pty ((Automated)"
    local EXPECTED="Verify that sudo can only run other commands from a pseudo terminal.
Run the following command to verify Defaults use_pty is set:
# grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,\h*)?use_pty\b' /etc/sudoers*
Verify the output matches:
/etc/sudoers:Defaults use_pty
Run the follow command to to verify Defaults !use_pty is not set:
# grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,\h*)?!use_pty\b' /etc/sudoers*
Nothing should be returned"
    local RISK="Unknown"
    local DESC="sudo can be configured to run only from a pseudo terminal (pseudo-pty).

Rationale:
Attackers can run a malicious program using sudo which would fork a background
process that remains even when the main program has finished executing."
    local ATTACK="WARNING: Editing the sudo configuration incorrectly can cause sudo to stop
functioning. Always use visudo to modify sudo configuration files."
    local REMEDIATION="Edit the file /etc/sudoers with visudo or a file in /etc/sudoers.d/ with visudo -f
<PATH TO FILE> and add the following line:
Defaults use_pty
Edit the file /etc/sudoers with visudo and any files in /etc/sudoers.d/ with visudo
-f <PATH TO FILE> and remove any occurrence of !use_pty
Note:
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
