#!/usr/bin/env bash
# controls/5.1.18_sshd_maxstartups_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.18"
    local TITLE="Ensure sshd MaxStartups is configured ((Automated)"
    local EXPECTED="Run the following command to verify MaxStartups is 10:30:60 or more restrictive:
# sshd -T | awk '\$1 ~ /^\s*maxstartups/{split(\$2, a, \":\");{if(a[1] > 10 ||
a[2] > 30 || a[3] > 60) print \$0}}'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The MaxStartups parameter specifies the maximum number of concurrent
unauthenticated connections to the SSH daemon.

Rationale:
To protect a system from denial of service due to a large number of pending
authentication connection attempts, use the rate limiting function of MaxStartups to
protect availability of sshd logins and prevent overwhelming the daemon."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the MaxStartups parameter to 10:30:60 or
more restrictive above any Include entries as follows:
MaxStartups 10:30:60
Note: First occurrence of a option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
