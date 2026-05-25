#!/usr/bin/env bash
# controls/5.3.3.2.7_password_quality_checking_is_enforced.sh

execute_control() {
    local CONTROL_ID="5.3.3.2.7"
    local TITLE="Ensure password quality checking is enforced ((Automated)"
    local EXPECTED="Run the following command to verify that enforcing=0 has not been set in a
pwquality configuration file:
# grep -PHsi -- '^\h*enforcing\h*=\h*0\b' /etc/security/pwquality.conf
/etc/security/pwquality.conf.d/*.conf
Nothing should be returned
Run the following command to verify that the enforcing=0 argument has not been set
on the pam_pwquality module:
# grep -PHsi -'^\h*password\h+[^#\n\r]+\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?enforcing=0\b'
/etc/pam.d/common-password
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The pam_pwquality module can be configured to either reject a password if it fails the
checks, or only print a warning.
This is configured by setting the enforcing=<N> argument. If nonzero, a password will
be rejected if it fails the checks, otherwise only a warning message will be provided.
This setting applies only to the pam_pwquality module and possibly other applications
that explicitly change their behavior based on it. It does not affect pwmake(1) and
pwscore(1).

Rationale:
Strong passwords help protect systems from password attacks. Types of password
attacks include dictionary attacks, which attempt to use common words and phrases,
and brute force attacks, which try every possible combination of characters. Also
attackers may try to obtain the account database so they can use tools to discover the
accounts and passwords."
    local ATTACK=""
    local REMEDIATION="Run the following command:
# grep -Pl -- '\bpam_pwquality\.so\h+([^#\n\r]+\h+)?enforcing=0\b'
/usr/share/pam-configs/*
Edit any returned files and remove the enforcing=0 argument from the
pam_pwquality.so line(s)
Edit /etc/security/pwquality.conf and all files ending in .conf in the
/etc/security/pwquality.conf.d/ directory and remove or comment out any line
containing the enforcing = 0 argument:
Example:
# sed -ri 's/^\s*enforcing\s*=\s*0/# &/' /etc/security/pwquality.conf
/etc/security/pwquality.conf.d/*.conf"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
