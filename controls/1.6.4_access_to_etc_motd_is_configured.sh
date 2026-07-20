#!/usr/bin/env bash
# controls/1.6.4_access_to_etc_motd_is_configured.sh

execute_control() {
    local CONTROL_ID="1.6.4"
    local TITLE="Ensure access to /etc/motd is configured ((Automated)"
    local EXPECTED="Run the following command and verify that if /etc/motd exists, Access is 644 or more
restrictive, Uid and Gid are both 0/root:
# [ -e /etc/motd ] && stat -Lc 'Access: (%#a/%A)
%G)' /etc/motd
Access: (0644/-rw-r--r--)
-- OR -Nothing is returned
Uid: ( %u/ %U) Gid: { %g/
Uid: ( 0/ root) Gid: ( 0/ root)"
    local RISK="Unknown"
    local DESC="The contents of the /etc/motd file are displayed to users after login and function as a
message of the day for authenticated users.

Rationale:
- IF - the /etc/motd file does not have the correct access configured, it could be
modified by unauthorized users with incorrect or misleading information."
    local ATTACK=""
    local REMEDIATION="Run the following commands to set mode, owner, and group on /etc/motd:
# chown root:root \$(readlink -e /etc/motd)
# chmod u-x,go-wx \$(readlink -e /etc/motd)
- OR Run the following command to remove the /etc/motd file:
# rm /etc/motd"

    local RESULT="PASS"
    local CURRENT=""

    local STAT=$(stat -c "%a %U %G" /etc/motd 2>/dev/null || echo "missing")
    if [ "$STAT" = "missing" ]; then
        CURRENT="/etc/motd does not exist (pass)."
        RESULT="PASS"
    elif [ "$STAT" = "644 root root" ] || [ "$STAT" = "444 root root" ]; then
        CURRENT="/etc/motd permissions are $STAT."
        RESULT="PASS"
    else
        CURRENT="/etc/motd permissions are $STAT (expected 644 root root)."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
