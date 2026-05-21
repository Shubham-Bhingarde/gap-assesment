#!/usr/bin/env bash
# controls/5.2.6_sudo_timestamp_timeout_is_configured.sh

execute_control() {
    local CONTROL_ID="5.2.6"
    local TITLE="Ensure sudo timestamp_timeout is configured ((Automated)"
    local EXPECTED="Ensure that the caching timeout is not disabled and greater than 15 minutes.
Run the following command:
# grep -roP \"timestamp_timeout=\K[0-9]*\" /etc/sudoers*
If there is no timestamp_timeout configured in /etc/sudoers* then the default of 5
minutes is being used.
If the default value is being used, run the following command to verify the default is not
disabled or greater than 15 minutes:
# sudo -V | grep \"Authentication timestamp timeout:\"
Example output:
Authentication timestamp timeout: 15.0 minutes
Verify Authentication timestamp timeout:
•
•
•
Is not a negative number (disabled).
Is not greater than 15 minutes, and follows local site policy.
Follows local site policy"
    local RISK="Unknown"
    local DESC="sudo timestamp_timeout controls how long a user's sudo privileges remain active
after the initial password entry.

Rationale:
A timeout value reduces the window of opportunity for unauthorized privileged sudo
access."
    local ATTACK=""
    local REMEDIATION="Edit the file listed in the audit section with visudo -f <PATH TO FILE> and modify the
entry timestamp_timeout= to 15 minutes or less as per your site policy. The value is in
minutes. This particular entry may appear on its own, or on the same line as
env_reset. See the following two examples:
Example 1:
Defaults
env_reset, timestamp_timeout=15
Example 2:
Defaults
Defaults
timestamp_timeout=15
env_reset"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
