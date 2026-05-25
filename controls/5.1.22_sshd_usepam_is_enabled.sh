#!/usr/bin/env bash
# controls/5.1.22_sshd_usepam_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.1.22"
    local TITLE="Ensure sshd UsePAM is enabled ((Automated)"
    local EXPECTED="Run the following command to verify UsePAM is set to yes:
# sshd -T | grep usepam
usepam yes"
    local RISK="Unknown"
    local DESC="The UsePAM directive enables the Pluggable Authentication Module (PAM) interface. If
set to yes this will enable PAM authentication using
ChallengeResponseAuthentication and PasswordAuthentication directives in
addition to PAM account and session module processing for all authentication types.

Rationale:
When usePAM is set to yes, PAM runs through account and session types properly. This
is important if you want to restrict access to services based off of IP, time or other
factors of the account. Additionally, you can make sure users inherit certain
environment variables on login or disallow access to the server"
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the UsePAM parameter to yes above any
Include entries as follows:
UsePAM yes
Note: First occurrence of an option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
