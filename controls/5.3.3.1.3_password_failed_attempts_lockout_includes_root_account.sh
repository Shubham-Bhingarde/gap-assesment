#!/usr/bin/env bash
# controls/5.3.3.1.3_password_failed_attempts_lockout_includes_root_account.sh

execute_control() {
    local CONTROL_ID="5.3.3.1.3"
    local TITLE="Ensure password failed attempts lockout includes root account ((Automated)"
    local EXPECTED="Run the following command to verify that even_deny_root and/or root_unlock_time
is enabled:
# grep -Pi -- '^\h*(even_deny_root|root_unlock_time\h*=\h*\d+)\b'
/etc/security/faillock.conf
Example output:
even_deny_root
--AND/OR-root_unlock_time = 60
Run the following command to verify that - IF - root_unlock_time is set, it is set to 60
(One minute) or more:
# grep -Pi -- '^\h*root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b'
/etc/security/faillock.conf
Nothing should be returned
Run the following command to check the pam_faillock.so module for the
root_unlock_time argument. Verify -IF- root_unlock_time is set, it is set to 60 (One
minute) or more:
# grep -Pi -'^\h*auth\h+([^#\n\r]+\h+)pam_faillock\.so\h+([^#\n\r]+\h+)?root_unlock_time\
h*=\h*([1-9]|[1-5][0-9])\b' /etc/pam.d/common-auth
Nothing should be returned"
    local RISK="Unknown"
    local DESC="even_deny_root - Root account can become locked as well as regular accounts
root_unlock_time=n - This option implies even_deny_root option. Allow access after n
seconds to root account after the account is locked. In case the option is not specified
the value is the same as of the unlock_time option.

Rationale:
Locking out user IDs after n unsuccessful consecutive login attempts mitigates brute
force password attacks against your systems."
    local ATTACK="Use of unlock_time=0 or root_unlock_time=0 may allow an attacker to cause denial
of service to legitimate users."
    local REMEDIATION="Edit /etc/security/faillock.conf:
•
•
Remove or update any line containing root_unlock_time, - OR - set it to a
value of 60 or more
Update or add the following line:
even_deny_root
Run the following command:
# grep -Pl -'\bpam_faillock\.so\h+([^#\n\r]+\h+)?(even_deny_root|root_unlock_time)'
/usr/share/pam-configs/*
Edit any returned files and remove the even_deny_root and root_unlock_time
arguments from the pam_faillock.so line(s):"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
