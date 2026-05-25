#!/usr/bin/env bash
# controls/5.3.3.2.6_password_dictionary_check_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.3.3.2.6"
    local TITLE="Ensure password dictionary check is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that the dictcheck option is not set to 0 (disabled)
in a pwquality configuration file:
# grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf
/etc/security/pwquality.conf.d/*.conf
Nothing should be returned
Run the following command to verify that the dictcheck option is not set to 0 (disabled)
as a module argument in a PAM file:
# grep -Psi -'^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\
r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/common-password
Nothing should be returned
Note:
•
•
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
    local DESC="The pwquality dictcheck option sets whether to check for the words from the
cracklib dictionary.

Rationale:
If the operating system allows the user to select passwords based on dictionary words,
this increases the chances of password compromise by increasing the opportunity for
successful guesses, and brute-force attacks."
    local ATTACK=""
    local REMEDIATION="Edit any file ending in .conf in the /etc/security/pwquality.conf.d/ directory
and/or the file /etc/security/pwquality.conf and comment out or remove any
instance of dictcheck = 0:
Example:
# sed -ri 's/^\s*dictcheck\s*=/# &/' /etc/security/pwquality.conf
/etc/security/pwquality.conf.d/*.conf
Run the following command:
# grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\b'
/usr/share/pam-configs/*
Edit any returned files and remove the dictcheck argument from the
pam_pwquality.so line(s)"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
