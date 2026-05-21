#!/usr/bin/env bash
# controls/2.3.2.2_systemd_timesyncd_is_enabled_and_running.sh

execute_control() {
    local CONTROL_ID="2.3.2.2"
    local TITLE="Ensure systemd-timesyncd is enabled and running ((Automated)"
    local EXPECTED="- IF - systemd-timesyncd is in use on the system, run the following commands:
Run the following command to verify that the systemd-timesyncd service is enabled:
# systemctl is-enabled systemd-timesyncd.service
enabled
Run the following command to verify that the systemd-timesyncd service is active:
# systemctl is-active systemd-timesyncd.service
active"
    local RISK="Unknown"
    local DESC="systemd-timesyncd is a daemon that has been added for synchronizing the system
clock across the network

Rationale:
systemd-timesyncd needs to be enabled and running in order to synchronize the system
to a timeserver.
Time synchronization is important to support time sensitive security mechanisms and to
ensure log files have consistent time records across the enterprise to aid in forensic
investigations"
    local ATTACK=""
    local REMEDIATION="- IF - systemd-timesyncd is in use on the system, run the following commands:
Run the following command to unmask systemd-timesyncd.service:
# systemctl unmask systemd-timesyncd.service
Run the following command to enable and start systemd-timesyncd.service:
# systemctl --now enable systemd-timesyncd.service
- OR If another time synchronization service is in use on the system, run the following
command to stop and mask systemd-timesyncd:
# systemctl --now mask systemd-timesyncd.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
