#!/usr/bin/env bash
# controls/5.1.17_sshd_maxsessions_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.17"
    local TITLE="Ensure sshd MaxSessions is configured ((Automated)"
    local EXPECTED="Run the following command and verify that MaxSessions is 10 or less:
# sshd -T | grep maxsessions
maxsessions 10
Run the following command and verify the output:
grep -Psi -- '^\h*MaxSessions\h+\\"?(1[1-9]|[2-9][0-9]|[1-9][0-9][0-9]+)\b'
/etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf
Nothing should be returned
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep maxsessions
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain)"
    local RISK="Unknown"
    local DESC="The MaxSessions parameter specifies the maximum number of open sessions
permitted from a given connection.

Rationale:
To protect a system from denial of service due to a large number of concurrent
sessions, use the rate limiting function of MaxSessions to protect availability of sshd
logins and prevent overwhelming the daemon."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the MaxSessions parameter to 10 or less
above any Include and Match entries as follows:
MaxSessions 10
Note: First occurrence of an option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
