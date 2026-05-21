#!/usr/bin/env bash
# controls/5.2.4_users_must_provide_password_for_escalation.sh

execute_control() {
    local CONTROL_ID="5.2.4"
    local TITLE="Ensure users must provide password for escalation ((Automated)"
    local EXPECTED="Note: If passwords are not being used for authentication, this is not applicable.
Verify the operating system requires users to supply a password for privilege escalation.
Check the configuration of the /etc/sudoers and /etc/sudoers.d/* files with the
following command:
# grep -r \"^[^#].*NOPASSWD\" /etc/sudoers*
If any line is found refer to the remediation procedure below."
    local RISK="Unknown"
    local DESC="The operating system must be configured so that users must provide a password for
privilege escalation.

Rationale:
Without (re-)authentication, users may access resources or perform tasks for which they
do not have authorization.
When operating systems provide the capability to escalate a functional capability, it is
critical the user (re-)authenticate."
    local ATTACK="This will prevent automated processes from being able to elevate privileges."
    local REMEDIATION="Based on the outcome of the audit procedure, use visudo -f <PATH TO FILE> to edit
the relevant sudoers file.
Remove any line with occurrences of NOPASSWD tags in the file."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
