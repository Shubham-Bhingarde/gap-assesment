#!/usr/bin/env bash
# controls/5.3.3.4.1_pam_unix_does_not_include_nullok.sh

execute_control() {
    local CONTROL_ID="5.3.3.4.1"
    local TITLE="Ensure pam_unix does not include nullok ((Automated)"
    local EXPECTED="Run the following command to verify that the nullok argument is not set on the
pam_unix.so module:
# grep -PHs -- '^\h*[^#\n\r]+\h+pam_unix\.so\h+([^#\n\r]+\h+)?nullok\b'
/etc/pam.d/common-{password,auth,account,session,session-noninteractive}
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The nullok argument overrides the default action of pam_unix.so to not permit the
user access to a service if their official password is blank.

Rationale:
Using a strong password is essential to helping protect personal and sensitive
information from unauthorized access"
    local ATTACK=""
    local REMEDIATION="Run the following command:
# grep -PH -- '^\h*([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?nullok\b'
/usr/share/pam-configs/*
Edit any files returned and remove the nullok argument for the pam_unix lines
Example File:
Name: Unix authentication
Default: yes
Priority: 256
Auth-Type: Primary
Auth:
[success=end default=ignore]
pam_unix.so try_first_pass # <**ensure line does not include nullok nullok**
Auth-Initial:
[success=end default=ignore]
pam_unix.so # <- **ensure line does
not include nullok nullok**
Account-Type: Primary
Account:
[success=end new_authtok_reqd=done default=ignore]
pam_unix.so
Account-Initial:
[success=end new_authtok_reqd=done default=ignore]
pam_unix.so
Session-Type: Additional
Session:
required
pam_unix.so
Session-Initial:
required
pam_unix.so
Password-Type: Primary
Password:
[success=end default=ignore]
pam_unix.so obscure use_authtok
try_first_pass yescrypt
Password-Initial:
[success=end default=ignore]
pam_unix.so obscure yescrypt
Run the following command to update the files in the /etc/pam.d/ directory:
# pam-auth-update --enable <EDITED_PROFILE_NAME>
Example:
# pam-auth-update --enable unix
Note: If custom files are being used, the corresponding files in /etc/pam.d/ would
need to be edited directly, and the pam-auth-update --enable
<EDITED_PROFILE_NAME> command skipped"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
