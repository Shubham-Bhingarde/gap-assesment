#!/usr/bin/env bash
# controls/5.3.3.3.1_password_history_remember_is_configured.sh

execute_control() {
    local CONTROL_ID="5.3.3.3.1"
    local TITLE="Ensure password history remember is configured ((Automated)"
    local EXPECTED="Run the following command and verify:
•
•
•
The pwhistory line in /etc/pam.d/common-password includes remember=<N>
The value of <N> is 24 or more
The value meets local site policy
# grep -Psi -'^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?remember=\d+\b
' /etc/pam.d/common-password
Output should be similar to:
password
requisite
use_authtok
pam_pwhistory.so remember=24 enforce_for_root"
    local RISK="Unknown"
    local DESC="The /etc/security/opasswd file stores the users' old passwords and can be checked
to ensure that users are not recycling recent passwords. The number of passwords
remembered is set via the remember argument value in set for the pam_pwhistory
module.
•
remember=<N> - <N> is the number of old passwords to remember

Rationale:
Requiring users not to reuse their passwords make it less likely that an attacker will be
able to guess the password or use a compromised password.
Note: These change only apply to accounts configured on the local system."
    local ATTACK=""
    local REMEDIATION="Run the following command:
# awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if
(/pam_pwhistory\.so/) print FILENAME}' /usr/share/pam-configs/*
Edit any returned files and edit or add the remember= argument, with a value of 24 or
more, that meets local site policy to the pam_pwhistory line in the Password section:
Example File:
Name: pwhistory password history checking
Default: yes
Priority: 1024
Password-Type: Primary
Password:
requisite
pam_pwhistory.so remember=24 enforce_for_root use_authtok # <**ensure line includes remember=<N>**
Run the following command to update the files in the /etc/pam.d/ directory:
# pam-auth-update --enable <MODIFIED_PROFILE_NAME>
Example:
# pam-auth-update --enable pwhistory"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
