#!/usr/bin/env bash
# controls/5.3.3.1.1_password_failed_attempts_lockout_is_configured.sh

execute_control() {
    local CONTROL_ID="5.3.3.1.1"
    local TITLE="Ensure password failed attempts lockout is configured ((Automated)"
    local EXPECTED="Run the following command to verify that Number of failed logon attempts before the
account is locked is no greater than 5 and meets local site policy:
# grep -Pi -- '^\h*deny\h*=\h*[1-5]\b' /etc/security/faillock.conf
deny = 5
Run the following command to verify that the deny argument has not been set, or 5 or
less and meets local site policy:
# grep -Pi -'^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h
+)?deny\h*=\h*(0|[6-9]|[1-9][0-9]+)\b' /etc/pam.d/common-auth
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The deny=<n> option will deny access if the number of consecutive authentication
failures for this user during the recent interval exceeds .

Rationale:
Locking out user IDs after n unsuccessful consecutive login attempts mitigates brute
force password attacks against your systems."
    local ATTACK=""
    local REMEDIATION="Create or edit the following line in /etc/security/faillock.conf setting the deny
option to 5 or less:
deny = 5
Run the following command:
# grep -Pl -- '\bpam_faillock\.so\h+([^#\n\r]+\h+)?deny\b' /usr/share/pamconfigs/*
Edit any returned files and remove the deny=<N> arguments from the
pam_faillock.so line(s):"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
