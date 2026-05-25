#!/usr/bin/env bash
# controls/5.4.1.3_password_expiration_warning_days_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.1.3"
    local TITLE="Ensure password expiration warning days is configured ((Automated)"
    local EXPECTED="Run the following command and verify PASS_WARN_AGE is 7 or more and follows local
site policy:
# grep -Pi -- '^\h*PASS_WARN_AGE\h+\d+\b' /etc/login.defs
Example output:
PASS_WARN_AGE 7
Run the following command to verify all passwords have a PASS_WARN_AGE of 7 or
more:
# awk -F: '(\$2~/^\\$.+\\$/) {if(\$6 < 7)print \"User: \" \$1 \" PASS_WARN_AGE: \"
\$6}' /etc/shadow
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The PASS_WARN_AGE parameter in /etc/login.defs allows an administrator to notify
users that their password will expire in a defined number of days.
PASS_WARN_AGE <N> - The number of days warning given before a password expires. A
zero means warning is given only upon the day of expiration, a negative value means
no warning is given. If not specified, no warning will be provided.

Rationale:
Providing an advance warning that a password will be expiring gives users time to think
of a secure password. Users caught unaware may choose a simple password or write it
down where it may be discovered."
    local ATTACK=""
    local REMEDIATION="Edit /etc/login.defs and set PASS_WARN_AGE to a value of 7 or more that follows
local site policy:
Example:
PASS_WARN_AGE 7
Run the following command to modify user parameters for all users with a password set
to a minimum warning to 7 or more days that follows local site policy:
# chage --warndays <N> <user>
Example:
# awk -F: '(\$2~/^\\$.+\\$/) {if(\$6 < 7)system (\"chage --warndays 7 \" \$1)}'
/etc/shadow"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
