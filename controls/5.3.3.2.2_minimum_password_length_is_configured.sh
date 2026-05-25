#!/usr/bin/env bash
# controls/5.3.3.2.2_minimum_password_length_is_configured.sh

execute_control() {
    local CONTROL_ID="5.3.3.2.2"
    local TITLE="Ensure minimum password length is configured ((Automated)"
    local EXPECTED="Run the following command to verify that password length is 14 or more characters, and
conforms to local site policy:
# grep -Psi -- '^\h*minlen\h*=\h*(1[4-9]|[2-9][0-9]|[1-9][0-9]{2,})\b'
/etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
Example output:
/etc/security/pwquality.conf.d/50-pwlength.conf:minlen = 14
Verify returned value(s) are no less than 14 characters and meet local site policy
Run the following command to verify that minlen is not set, or is 14 or more characters,
and conforms to local site policy:
# grep -Psi -'^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\
r]+\h+)?minlen\h*=\h*([0-9]|1[0-3])\b' /etc/pam.d/system-auth
/etc/pam.d/common-password
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
    local DESC="The minimum password length setting determines the lowers number of characters that
make up a password for a user account. There are many different theories about how to
determine the best password length for an organization, but perhaps \"passphrase\" is a
better term than \"password\".
The minlen option sets the minimum acceptable size for the new password (plus one if
credits are not disabled which is the default). Cannot be set to lower value than 6.

Rationale:
Strong passwords help protect systems from password attacks. Types of password
attacks include dictionary attacks, which attempt to use common words and phrases,
and brute force attacks, which try every possible combination of characters. Also
attackers may try to obtain the account database so they can use tools to discover the
accounts and passwords."
    local ATTACK="In general, it is true that longer passwords are better (harder to crack), but it is also true
that forced password length requirements can cause user behavior that is predictable
and undesirable. For example, requiring users to have a minimum 16-character
password may cause them to choose repeating patterns like fourfourfourfour or
passwordpassword that meet the requirement but aren’t hard to guess. Additionally,
length requirements increase the chances that users will adopt other insecure practices,
like writing them down, re-using them or storing them unencrypted in their documents.
Having a reasonable minimum length with no maximum character limit increases the
resulting average password length used (and therefore the strength).6"
    local REMEDIATION="Create or modify a file ending in .conf in the /etc/security/pwquality.conf.d/
directory or the file /etc/security/pwquality.conf and add or modify the following
line to set password length of 14 or more characters. Ensure that password length
conforms to local site policy:
Example:
#!/usr/bin/env bash
{
sed -ri 's/^\s*minlen\s*=/# &/' /etc/security/pwquality.conf
[ ! -d /etc/security/pwquality.conf.d/ ] && mkdir
/etc/security/pwquality.conf.d/
printf '\n%s' \"minlen = 14\" > /etc/security/pwquality.conf.d/50pwlength.conf
}
Run the following command:
# grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?minlen\b' /usr/share/pamconfigs/*
Edit any returned files and remove the minlen argument from the pam_pwquality.so
line(s):"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
