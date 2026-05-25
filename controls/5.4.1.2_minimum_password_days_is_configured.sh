#!/usr/bin/env bash
# controls/5.4.1.2_minimum_password_days_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.1.2"
    local TITLE="Ensure minimum password days is configured ((Manual)"
    local EXPECTED="Run the following command to verify that PASS_MIN_DAYS is set to a value greater than
0 and follows local site policy:
# grep -Pi -- '^\h*PASS_MIN_DAYS\h+\d+\b' /etc/login.defs
Example output:
PASS_MIN_DAYS
1
Run the following command to verify all passwords have a PASS_MIN_DAYS greater than
0:
# awk -F: '(\$2~/^\\$.+\\$/) {if(\$4 < 1)print \"User: \" \$1 \" PASS_MIN_DAYS: \"
\$4}' /etc/shadow
Nothing should be returned"
    local RISK="Unknown"
    local DESC="PASS_MIN_DAYS <N> - The minimum number of days allowed between password
changes. Any password changes attempted sooner than this will be rejected. If not
specified, 0 will be assumed (which disables the restriction).

Rationale:
Users may have favorite passwords that they like to use because they are easy to
remember and they believe that their password choice is secure from compromise.
Unfortunately, passwords are compromised and if an attacker is targeting a specific
individual user account, with foreknowledge of data about that user, reuse of old,
potentially compromised passwords, may cause a security breach.
By restricting the frequency of password changes, an administrator can prevent users
from repeatedly changing their password in an attempt to circumvent password reuse
controls"
    local ATTACK="If a users password is set by other personnel as a procedure in dealing with a lost or
expired password, the user should be forced to update this \"set\" password with their
own password. e.g. force \"change at next logon\".
If it is not possible to have a user set their own password immediately, and this
recommendation or local site procedure may cause a user to continue using a third
party generated password, PASS_MIN_DAYS for the effected user should be temporally
changed to 0via chage --mindays <user>, to allow a user to change their password
immediately.
For applications where the user is not using the password at console, the ability to
\"change at next logon\" may be limited. This may cause a user to continue to use a
password created by other personnel."
    local REMEDIATION="Edit /etc/login.defs and set PASS_MIN_DAYS to a value greater than 0 that follows
local site policy:
Example:
PASS_MIN_DAYS 1
Run the following command to modify user parameters for all users with a password set
to a minimum days greater than zero that follows local site policy:
# chage --mindays <N> <user>
Example:
# awk -F: '(\$2~/^\\$.+\\$/) {if(\$4 < 1)system (\"chage --mindays 1 \" \$1)}'
/etc/shadow"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
