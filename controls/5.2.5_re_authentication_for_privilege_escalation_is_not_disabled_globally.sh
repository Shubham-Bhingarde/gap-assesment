#!/usr/bin/env bash
# controls/5.2.5_re_authentication_for_privilege_escalation_is_not_disabled_globally.sh

execute_control() {
    local CONTROL_ID="5.2.5"
    local TITLE="Ensure re-authentication for privilege escalation is not disabled globally ((Automated)"
    local EXPECTED="Verify the operating system requires users to re-authenticate for privilege escalation.
Check the configuration of the /etc/sudoers and /etc/sudoers.d/* files with the
following command:
# grep -r \"^[^#].*\!authenticate\" /etc/sudoers*
If any line is found with a !authenticate tag, refer to the remediation procedure below."
    local RISK="Unknown"
    local DESC="The operating system must be configured so that users must re-authenticate for
privilege escalation.

Rationale:
Without re-authentication, users may access resources or perform tasks for which they
do not have authorization.
When operating systems provide the capability to escalate a functional capability, it is
critical the user re-authenticate."
    local ATTACK=""
    local REMEDIATION="Configure the operating system to require users to reauthenticate for privilege
escalation.
Based on the outcome of the audit procedure, use visudo -f <PATH TO FILE> to edit
the relevant sudoers file.
Remove any occurrences of !authenticate tags in the file(s)."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
