#!/usr/bin/env bash
# controls/1.6.5_access_to_etc_issue_is_configured.sh

execute_control() {
    local CONTROL_ID="1.6.5"
    local TITLE="Ensure access to /etc/issue is configured ((Automated)"
    local EXPECTED="Run the following command and verify Access is 644 or more restrictive and Uid and
Gid are both 0/root:
# stat -Lc 'Access: (%#a/%A)
Access: (0644/-rw-r--r--)
Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/issue
Uid: ( 0/ root) Gid: { 0/ root)"
    local RISK="Unknown"
    local DESC="The contents of the /etc/issue file are displayed to users prior to login for local
terminals.

Rationale:
- IF - the /etc/issue file does not have the correct access configured, it could be
modified by unauthorized users with incorrect or misleading information."
    local ATTACK=""
    local REMEDIATION="Run the following commands to set mode, owner, and group on /etc/issue:
# chown root:root \$(readlink -e /etc/issue)
# chmod u-x,go-wx \$(readlink -e /etc/issue)"

    local RESULT="PASS"
    local CURRENT=""

    local STAT=$(stat -c "%a %U %G" /etc/issue 2>/dev/null || echo "missing")
    if [ "$STAT" = "missing" ]; then
        CURRENT="/etc/issue does not exist (pass)."
        RESULT="PASS"
    elif [ "$STAT" = "644 root root" ] || [ "$STAT" = "444 root root" ]; then
        CURRENT="/etc/issue permissions are $STAT."
        RESULT="PASS"
    else
        CURRENT="/etc/issue permissions are $STAT (expected 644 root root)."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
