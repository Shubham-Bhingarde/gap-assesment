#!/usr/bin/env bash
# controls/5.1.16_sshd_maxauthtries_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.16"
    local TITLE="Ensure sshd MaxAuthTries is configured ((Automated)"
    local EXPECTED="Run the following command and verify that MaxAuthTries is 4 or less:
# sshd -T | grep maxauthtries
maxauthtries 4
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep maxauthtries
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain)"
    local RISK="Unknown"
    local DESC="The MaxAuthTries parameter specifies the maximum number of authentication
attempts permitted per connection. When the login failure count reaches half the
number, error messages will be written to the syslog file detailing the login failure.

Rationale:
Setting the MaxAuthTries parameter to a low number will minimize the risk of
successful brute force attacks to the SSH server. While the recommended setting is 4,
set the number based on site policy."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the MaxAuthTries parameter to 4 or less
above any Include and Match entries as follows:
MaxAuthTries 4
Note: First occurrence of an option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
