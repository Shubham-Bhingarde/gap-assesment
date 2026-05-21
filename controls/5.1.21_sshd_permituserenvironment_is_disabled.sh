#!/usr/bin/env bash
# controls/5.1.21_sshd_permituserenvironment_is_disabled.sh

execute_control() {
    local CONTROL_ID="5.1.21"
    local TITLE="Ensure sshd PermitUserEnvironment is disabled ((Automated)"
    local EXPECTED="Run the following command to verify PermitUserEnvironment is set to no:
# sshd -T | grep permituserenvironment
permituserenvironment no"
    local RISK="Unknown"
    local DESC="The PermitUserEnvironment option allows users to present environment options to
the SSH daemon.

Rationale:
Permitting users the ability to set environment variables through the SSH daemon could
potentially allow users to bypass security controls (e.g. setting an execution path that
has SSH executing trojan'd programs)"
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the PermitUserEnvironment parameter to
no above any Include entries as follows:
PermitUserEnvironment no
Note: First occurrence of an option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
