#!/usr/bin/env bash
# controls/5.3.3.2.1_password_number_of_changed_characters_is_configured.sh

execute_control() {
    local CONTROL_ID="5.3.3.2.1"
    local TITLE="Ensure password number of changed characters is configured ((Automated)"
    local EXPECTED="Run the following command to verify that the difok option is set to 2 or more and
follows local site policy:
# grep -Psi -- '^\h*difok\h*=\h*([2-9]|[1-9][0-9]+)\b'
/etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
Example output:
/etc/security/pwquality.conf.d/50-pwdifok.conf:difok = 2
Verify returned value(s) are 2 or more and meet local site policy
Run the following command to verify that difok is not set, is 2 or more, and conforms to
local site policy:
grep -Psi -'^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\
r]+\h+)?difok\h*=\h*([0-1])\b' /etc/pam.d/common-password
Nothing should be returned
Note:
•
•
•
settings should be configured in only one location for clarity
Settings observe an order of precedence:
o module arguments override the settings in the
/etc/security/pwquality.conf configuration file
o settings in the /etc/security/pwquality.conf configuration file
override settings in a .conf file in the
/etc/security/pwquality.conf.d/ directory
o settings in a .conf file in the /etc/security/pwquality.conf.d/
directory are read in canonical order, with last read file containing the
setting taking precedence
It is recommended that settings be configured in a .conf file in the
/etc/security/pwquality.conf.d/ directory for clarity, convenience, and
durability."
    local RISK="Unknown"
    local DESC="The pwquality difok option sets the number of characters in a password that must not
be present in the old password.

Rationale:
Use of a complex password helps to increase the time and resources required to
compromise the password. Password complexity, or strength, is a measure of the
effectiveness of a password in resisting attempts at guessing and brute-force attacks.
Password complexity is one factor of several that determines how long it takes to crack
a password. The more complex the password, the greater the number of possible
combinations that need to be tested before the password is compromised."
    local ATTACK=""
    local REMEDIATION="Create or modify a file ending in .conf in the /etc/security/pwquality.conf.d/
directory or the file /etc/security/pwquality.conf and add or modify the following
line to set difok to 2 or more. Ensure setting conforms to local site policy:
Example:
#!/usr/bin/env bash
{
sed -ri 's/^\s*difok\s*=/# &/' /etc/security/pwquality.conf
[ ! -d /etc/security/pwquality.conf.d/ ] && mkdir
/etc/security/pwquality.conf.d/
printf '\n%s' \"difok = 2\" > /etc/security/pwquality.conf.d/50-pwdifok.conf
}
Run the following command:
# grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?difok\b' /usr/share/pamconfigs/*
Edit any returned files and remove the difok argument from the pam_pwquality.so
line(s):"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
