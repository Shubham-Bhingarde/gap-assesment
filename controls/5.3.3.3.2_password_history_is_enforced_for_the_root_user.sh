#!/usr/bin/env bash
# controls/5.3.3.3.2_password_history_is_enforced_for_the_root_user.sh

execute_control() {
    local CONTROL_ID="5.3.3.3.2"
    local TITLE="Ensure password history is enforced for the root user ((Automated)"
    local EXPECTED="Run the following command to verify that the enforce_for_root argument is exists on
the pwhistory line in /etc/pam.d/common-password:
# grep -Psi -'^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?enforce_for_ro
ot\b' /etc/pam.d/common-password
Output should be similar to:
password
requisite
use_authtok
pam_pwhistory.so remember=24 enforce_for_root"
    local RISK="Unknown"
    local DESC="If the pwhistory enforce_for_root option is enabled, the module will enforce
password history for the root user as well

Rationale:
Requiring users not to reuse their passwords make it less likely that an attacker will be
able to guess the password or use a compromised password
Note: These change only apply to accounts configured on the local system."
    local ATTACK=""
    local REMEDIATION="Run the following command:
# awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if
(/pam_pwhistory\.so/) print FILENAME}' /usr/share/pam-configs/*
Edit any returned files and add the enforce_for_root argument to the
pam_pwhistory line in the Password section:
Example File:
Name: pwhistory password history checking
Default: yes
Priority: 1024
Password-Type: Primary
Password:
requisite
pam_pwhistory.so remember=24 enforce_for_root use_authtok # <**ensure line includes enforce_for_root**
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
