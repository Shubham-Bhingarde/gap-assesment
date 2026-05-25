#!/usr/bin/env bash
# controls/5.1.11_sshd_ignorerhosts_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.1.11"
    local TITLE="Ensure sshd IgnoreRhosts is enabled ((Automated)"
    local EXPECTED="Run the following command to verify IgnoreRhosts is set to yes:
# sshd -T | grep ignorerhosts
ignorerhosts yes"
    local RISK="Unknown"
    local DESC="The IgnoreRhosts parameter specifies that .rhosts and .shosts files will not be used
in RhostsRSAAuthentication or HostbasedAuthentication.

Rationale:
Setting this parameter forces users to enter a password when authenticating with SSH."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the IgnoreRhosts parameter to yes above
any Include entry as follows:
IgnoreRhosts yes
Note: First occurrence of a option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
