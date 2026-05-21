#!/usr/bin/env bash
# controls/5.2.7_access_to_the_su_command_is_restricted.sh

execute_control() {
    local CONTROL_ID="5.2.7"
    local TITLE="Ensure access to the su command is restricted ((Automated)"
    local EXPECTED="Run the following command:
# grep -Pi
'^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)
(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\
h+.*)?\$' /etc/pam.d/su
Verify the output matches:
auth required pam_wheel.so use_uid group=<group_name>
Run the following command and verify that the group specified in <group_name>
contains no users:
# grep <group_name> /etc/group
Verify the output does not contain any users in the relevant group:
<group_name>:x:<GID>:"
    local RISK="Unknown"
    local DESC="The su command allows a user to run a command or shell as another user. The
program has been superseded by sudo, which allows for more granular control over
privileged access. Normally, the su command can be executed by any user. By
uncommenting the pam_wheel.so statement in /etc/pam.d/su, the su command will
only allow users in a specific groups to execute su. This group should be empty to
reinforce the use of sudo for privileged access.

Rationale:
Restricting the use of su , and using sudo in its place, provides system administrators
better control of the escalation of user privileges to execute privileged commands. The
sudo utility also provides a better logging and audit mechanism, as it can log each
command executed via sudo , whereas su can only record that a user executed the su
program."
    local ATTACK=""
    local REMEDIATION="Create an empty group that will be specified for use of the su command. The group
should be named according to site policy.
Example:
# groupadd sugroup
Add the following line to the /etc/pam.d/su file, specifying the empty group:
auth required pam_wheel.so use_uid group=sugroup"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
