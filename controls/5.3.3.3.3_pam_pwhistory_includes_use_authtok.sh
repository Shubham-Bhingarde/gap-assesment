#!/usr/bin/env bash
# controls/5.3.3.3.3_pam_pwhistory_includes_use_authtok.sh

execute_control() {
    local CONTROL_ID="5.3.3.3.3"
    local TITLE="Ensure pam_pwhistory includes use_authtok ((Automated)"
    local EXPECTED="Run the following command to verify that the use_authtok argument exists on the
pwhistory line in /etc/pam.d/common-password:
# grep -Psi -'^\h*password\h+[^#\n\r]+\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b'
/etc/pam.d/common-password
Output should be similar to:
password
requisite
use_authtok
pam_pwhistory.so remember=24 enforce_for_root"
    local RISK="Unknown"
    local DESC="use_authtok - When password changing enforce the module to set the new password
to the one provided by a previously stacked password module

Rationale:
use_authtok allows multiple pam modules to confirm a new password before it is
accepted."
    local ATTACK=""
    local REMEDIATION="Run the following command:
# awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if
(/pam_pwhistory\.so/) print FILENAME}' /usr/share/pam-configs/*
Edit any returned files and add the use_authtok argument to the pam_pwhistory line
in the Password section:
Example File:
Name: pwhistory password history checking
Default: yes
Priority: 1024
Password-Type: Primary
Password:
requisite
pam_pwhistory.so remember=24 enforce_for_root use_authtok # <**ensure line includes use_authtok**
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
