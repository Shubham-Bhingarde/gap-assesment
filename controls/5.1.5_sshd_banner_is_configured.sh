#!/usr/bin/env bash
# controls/5.1.5_sshd_banner_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.5"
    local TITLE="Ensure sshd Banner is configured ((Automated)"
    local EXPECTED="Run the following command to verify Banner is set:
# sshd -T | grep -Pi -- '^banner\h+\/\H+'
Example:
banner /etc/issue.net
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep -Pi -- '^banner\h+\/\H+'
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain).
Run the following command and verify that the contents or the file being called by the
Banner argument match site policy:
# [ -e \"\$(sshd -T | awk '\$1 == \"banner\" {print \$2}')\" ] && cat \"\$(sshd -T |
awk '\$1 == \"banner\" {print \$2}')\"
Run the following command and verify no results are returned:
# grep -Psi -- \"(\\\v|\\\r|\\\m|\\\s|\b\$(grep '^ID=' /etc/os-release | cut d= -f2 | sed -e 's/\"//g')\b)\" \"\$(sshd -T | awk '\$1 == \"banner\" {print \$2}')\""
    local RISK="Unknown"
    local DESC="The Banner parameter specifies a file whose contents must be sent to the remote user
before authentication is permitted. By default, no banner is displayed.

Rationale:
Banners are used to warn connecting users of the particular site's policy regarding
connection. Presenting a warning message prior to the normal user login may assist the
prosecution of trespassers on the computer system."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the Banner parameter above any Include
and Match entries as follows:
Banner /etc/issue.net
Note: First occurrence of a option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a file in Include location.
Edit the file being called by the Banner argument with the appropriate contents
according to your site policy, remove any instances of \m , \r , \s , \v or references to
the OS platform
Example:
# printf '%s\n' \"Authorized users only. All activity may be monitored and
reported.\" > \"\$(sshd -T | awk '\$1 == \"banner\" {print \$2}')\""

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
