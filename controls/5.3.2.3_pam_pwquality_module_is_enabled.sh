#!/usr/bin/env bash
# controls/5.3.2.3_pam_pwquality_module_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.3.2.3"
    local TITLE="Ensure pam_pwquality module is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that pam_pwquality.so is enabled:
# grep -P -- '\bpam_pwquality\.so\b' /etc/pam.d/common-password
Output should be similar to:
password
requisite
pam_pwquality.so retry=3"
    local RISK="Unknown"
    local DESC="The pam_pwquality.so module performs password quality checking. This module can
be plugged into the password stack of a given service to provide strength-checking for
passwords. The code was originally based on pam_cracklib module and the module is
backwards compatible with its options.
The action of this module is to prompt the user for a password and check its strength
against a system dictionary and a set of rules for identifying poor choices.
The first action is to prompt for a single password, check its strength and then, if it is
considered strong, prompt for the password a second time (to verify that it was typed
correctly on the first occasion). All being well, the password is passed on to subsequent
modules to be installed as the new authentication token.

Rationale:
Use of a unique, complex passwords helps to increase the time and resources required
to compromise the password."
    local ATTACK=""
    local REMEDIATION="Run the following script to verify the pam_pwquality.so line exists in a pam-authupdate profile:
# grep -P -- '\bpam_pwquality\.so\b' /usr/share/pam-configs/*
Output should be similar to:
/usr/share/pam-configs/pwquality:
pam_pwquality.so retry=3
/usr/share/pam-configs/pwquality:
pam_pwquality.so retry=3
requisite
requisite
- IF - similar output is returned:
Run the following command to update /etc/pam.d/common-password with the
returned profile:
# pam-auth-update --enable {PROFILE_NAME}
Example:
# pam-auth-update pwquality
- IF - similar output is NOT returned:
Create a pam-auth-update profile in /usr/share/pam-configs/ with the following
lines:
Name: Pwquality password strength checking
Default: yes
Priority: 1024
Conflicts: cracklib
Password-Type: Primary
Password:
requisite
pam_pwquality.so retry=3
Example:
#!/usr/bin/env bash
{
arr=('Name: Pwquality password strength checking' 'Default: yes'
'Priority: 1024' 'Conflicts: cracklib' 'Password-Type: Primary' 'Password:' '
requisite
pam_pwquality.so retry=3')
printf '%s\n' \"\${arr[@]}\" > /usr/share/pam-configs/pwquality
}
Run the following command to update /etc/pam.d/common-password with the
pwquality profile:
# pam-auth-update --enable pwquality
Note:
•
•
•
•
The name used for the file must be used in the pam-auth-update --enable
command
The Name: line should be easily recognizable and understood
The Priority: Line is important as it effects the order of the lines in the
/etc/pam.d/ files
If a site specific custom profile is being used in your environment to configure
PAM that includes the configuration for the pam_pwquality module, enable that
module instead"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
