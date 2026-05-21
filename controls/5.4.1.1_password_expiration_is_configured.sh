#!/usr/bin/env bash
# controls/5.4.1.1_password_expiration_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.1.1"
    local TITLE="Ensure password expiration is configured ((Automated)"
    local EXPECTED="Run the following command and verify PASS_MAX_DAYS is set to 365 days or less and
conforms to local site policy:
# grep -Pi -- '^\h*PASS_MAX_DAYS\h+\d+\b' /etc/login.defs
Example output:
PASS_MAX_DAYS 365
Run the following command to verify all /etc/shadow passwords PASS_MAX_DAYS:
•
•
•
is greater than 0 days
is less than or equal to 365 days
conforms to local site policy
# awk -F: '(\$2~/^\\$.+\\$/) {if(\$5 > 365 || \$5 < 1)print \"User: \" \$1 \"
PASS_MAX_DAYS: \" \$5}' /etc/shadow
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The PASS_MAX_DAYS parameter in /etc/login.defs allows an administrator to force
passwords to expire once they reach a defined age.
PASS_MAX_DAYS <N> - The maximum number of days a password may be used. If the
password is older than this, a password change will be forced. If not specified, -1 will be
assumed (which disables the restriction).

Rationale:
The window of opportunity for an attacker to leverage compromised credentials or
successfully compromise credentials via an online brute force attack is limited by the
age of the password. Therefore, reducing the maximum age of a password also reduces
an attacker's window of opportunity.
We recommend a yearly password change. This is primarily because for all their good
intentions users will share credentials across accounts. Therefore, even if a breach is
publicly identified, the user may not see this notification, or forget they have an account
on that site. This could leave a shared credential vulnerable indefinitely. Having an
organizational policy of a 1-year (annual) password expiration is a reasonable
compromise to mitigate this with minimal user burden."
    local ATTACK="The password expiration must be greater than the minimum days between password
changes or users will be unable to change their password.
Excessive password expiration requirements do more harm than good, because these
requirements make users select predictable passwords, composed of sequential words
and numbers that are closely related to each other. In these cases, the next password
can be predicted based on the previous one (incrementing a number used in the
password for example). Also, password expiration requirements offer no containment
benefits because attackers will often use credentials as soon as they compromise them.
Instead, immediate password changes should be based on key events including, but not
limited to:
•
•
•
Indication of compromise
Change of user roles
When a user leaves the organization.
Not only does changing passwords every few weeks or months frustrate the user, but
it’s also been suggested that it does more harm than good, because it could lead to bad
practices by the user such as adding a character to the end of their existing password."
    local REMEDIATION="Set the PASS_MAX_DAYS parameter to conform to site policy in /etc/login.defs :
PASS_MAX_DAYS 365
Modify user parameters for all users with a password set to match:
# chage --maxdays 365 <user>
Edit /etc/login.defs and set PASS_MAX_DAYS to a value greater than 0 that follows
local site policy:
Example:
PASS_MAX_DAYS 365
Run the following command to modify user parameters for all users with a password set
to a maximum age no greater than 365 or less than 1 that follows local site policy:
# chage --maxdays <N> <user>
Example:
# awk -F: '(\$2~/^\\$.+\\$/) {if(\$5 > 365 || \$5 < 1)system (\"chage --maxdays 365
\" \$1)}' /etc/shadow
Warning: If a password has been set at system install or kickstart, the last change
date field is not set, In this case, setting PASS_MAX_DAYS will immediately expire the
password. One possible solution is to populate the last change date field through a
command like: chage -d \"\$(date +%Y-%m-%d)\" root"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
