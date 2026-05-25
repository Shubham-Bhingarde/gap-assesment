#!/usr/bin/env bash
# controls/5.3.3.1.2_password_unlock_time_is_configured.sh

execute_control() {
    local CONTROL_ID="5.3.3.1.2"
    local TITLE="Ensure password unlock time is configured ((Automated)"
    local EXPECTED="Run the following command to verify that the time in seconds before the account is
unlocked is either 0 (never) or 900 (15 minutes) or more and meets local site policy:
# grep -Pi -- '^\h*unlock_time\h*=\h*(0|9[0-9][0-9]|[1-9][0-9]{3,})\b'
/etc/security/faillock.conf
unlock_time = 900
Run the following command to verify that the unlock_time argument has not been set,
or is either 0 (never) or 900 (15 minutes) or more and meets local site policy:
# grep -Pi -'^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h
+)?unlock_time\h*=\h*([1-9]|[1-9][0-9]|[1-8][0-9][0-9])\b' /etc/pam.d/commonauth
Nothing should be returned"
    local RISK="Unknown"
    local DESC="unlock_time=<n> - The access will be re-enabled after seconds after the lock out. The
value 0 has the same meaning as value never - the access will not be re-enabled
without resetting the faillock entries by the faillock(8) command.
Note:
•
•
•
The default directory that pam_faillock uses is usually cleared on system boot so
the access will be also re-enabled after system reboot. If that is undesirable a
different tally directory must be set with the dir option.
It is usually undesirable to permanently lock out users as they can become easily
a target of denial of service attack unless the usernames are random and kept
secret to potential attackers.
The maximum configurable value for unlock_time is 604800

Rationale:
Locking out user IDs after n unsuccessful consecutive login attempts mitigates brute
force password attacks against your systems."
    local ATTACK="Use of unlock_time=0 may allow an attacker to cause denial of service to legitimate
users. This will also require a systems administrator with elevated privileges to unlock
the account."
    local REMEDIATION="Set password unlock time to conform to site policy. unlock_time should be 0 (never),
or 900 seconds or greater.
Edit /etc/security/faillock.conf and update or add the following line:
unlock_time = 900
Run the following command: remove the unlock_time argument from the
pam_faillock.so module in the PAM files:
# grep -Pl -- '\bpam_faillock\.so\h+([^#\n\r]+\h+)?unlock_time\b'
/usr/share/pam-configs/*
Edit any returned files and remove the unlock_time=<N> argument from the
pam_faillock.so line(s):"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
