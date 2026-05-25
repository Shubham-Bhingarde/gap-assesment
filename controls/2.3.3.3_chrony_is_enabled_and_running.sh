#!/usr/bin/env bash
# controls/2.3.3.3_chrony_is_enabled_and_running.sh

execute_control() {
    local CONTROL_ID="2.3.3.3"
    local TITLE="Ensure chrony is enabled and running ((Automated)"
    local EXPECTED="- IF - chrony is in use on the system, run the following commands:
Run the following command to verify that the chrony service is enabled:
# systemctl is-enabled chrony.service
enabled
Run the following command to verify that the chrony service is active:
# systemctl is-active chrony.service
active"
    local RISK="Unknown"
    local DESC="chrony is a daemon for synchronizing the system clock across the network

Rationale:
chrony needs to be enabled and running in order to synchronize the system to a
timeserver.
Time synchronization is important to support time sensitive security mechanisms and to
ensure log files have consistent time records across the enterprise to aid in forensic
investigations"
    local ATTACK=""
    local REMEDIATION="- IF - chrony is in use on the system, run the following commands:
Run the following command to unmask chrony.service:
# systemctl unmask chrony.service
Run the following command to enable and start chrony.service:
# systemctl --now enable chrony.service
- OR If another time synchronization service is in use on the system, run the following
command to remove chrony:
# apt purge chrony
# apt autoremove chrony"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
