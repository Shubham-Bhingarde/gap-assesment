#!/usr/bin/env bash
# controls/5.1.20_sshd_permitrootlogin_is_disabled.sh

execute_control() {
    local CONTROL_ID="5.1.20"
    local TITLE="Ensure sshd PermitRootLogin is disabled ((Automated)"
    local EXPECTED="Run the following command to verify PermitRootLogin is set to no:
# sshd -T | grep permitrootlogin
permitrootlogin no
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep permitrootlogin
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain)"
    local RISK="Unknown"
    local DESC="The PermitRootLogin parameter specifies if the root user can log in using SSH. The
default is prohibit-password.

Rationale:
Disallowing root logins over SSH requires system admins to authenticate using their
own individual account, then escalating to root. This limits opportunity for nonrepudiation and provides a clear audit trail in the event of a security incident."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the PermitRootLogin parameter to no
above any Include and Match entries as follows:
PermitRootLogin no
Note: First occurrence of an option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
