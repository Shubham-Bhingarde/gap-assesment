#!/usr/bin/env bash
# controls/5.3.2.4_pam_pwhistory_module_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.3.2.4"
    local TITLE="Ensure pam_pwhistory module is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that pam_pwhistory.so is enabled:
# grep -P -- '\bpam_pwhistory\.so\b' /etc/pam.d/common-password
Output should be similar to:
password
requisite
use_authtok
pam_pwhistory.so remember=24 enforce_for_root"
    local RISK="Unknown"
    local DESC="The pam_pwhistory.so module saves the last passwords for each user in order to
force password change history and keep the user from alternating between the same
password too frequently.
This module does not work together with kerberos. In general, it does not make much
sense to use this module in conjunction with NIS or LDAP, since the old passwords are
stored on the local machine and are not available on another machine for password
history checking.

Rationale:
Use of a unique, complex passwords helps to increase the time and resources required
to compromise the password."
    local ATTACK=""
    local REMEDIATION="Run the following script to verify the pam_pwhistory.so line exists in a pam-authupdate profile:
# grep -P -- '\bpam_pwhistory\.so\b' /usr/share/pam-configs/*
Output should be similar to:
/usr/share/pam-configs/pwhistory:
enforce_for_root use_authtok
requisite
pam_pwhistory.so remember=24
- IF - similar output is returned:
Run the following command to update /etc/pam.d/common-password with the
returned profile:
# pam-auth-update --enable {PROFILE_NAME}
Example:
# pam-auth-update pwhistory
- IF - similar output is NOT returned:
Create a pwhistory profile in /usr/share/pam-configs/ with the following lines:
Name: pwhistory password history checking
Default: yes
Priority: 1024
Password-Type: Primary
Password: requisite pam_pwhistory.so remember=24 enforce_for_root use_authtok
Example Script:
#!/usr/bin/env bash
{
arr=('Name: pwhistory password history checking' 'Default: yes' 'Priority:
1024' 'Password-Type: Primary' 'Password:' '
requisite
pam_pwhistory.so remember=24 enforce_for_root use_authtok')
printf '%s\n' \"\${arr[@]}\" > /usr/share/pam-configs/pwhistory
}
Run the following command to update /etc/pam.d/common-password with the
pwhistory profile:
# pam-auth-update --enable pwhistory
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
PAM that includes the configuration for the pam_pwhistory module, enable that
module instead"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
