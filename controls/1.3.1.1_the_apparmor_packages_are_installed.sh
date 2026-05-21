#!/usr/bin/env bash
# controls/1.3.1.1_the_apparmor_packages_are_installed.sh

execute_control() {
    local CONTROL_ID="1.3.1.1"
    local TITLE="Ensure the apparmor packages are installed ((Automated)"
    local EXPECTED="Run the following command to verify that apparmor is installed:
# dpkg-query -s apparmor &>/dev/null && echo \"apparmor is installed\"
apparmor is installed
Run the following command to verify that apparmor-utils is installed:
# dpkg-query -s apparmor-utils &>/dev/null && echo \"apparmor-utils is
installed\"
apparmor-utils is installed"
    local RISK="Unknown"
    local DESC="AppArmor provides Mandatory Access Controls.

Rationale:
Without a Mandatory Access Control system installed only the default Discretionary
Access Control system will be available."
    local ATTACK=""
    local REMEDIATION="Run the following command to install apparmor and apparmor-utils:
# apt install apparmor apparmor-utils"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
