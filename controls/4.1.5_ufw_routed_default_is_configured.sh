#!/usr/bin/env bash
# controls/4.1.5_ufw_routed_default_is_configured.sh

execute_control() {
    local CONTROL_ID="4.1.5"
    local TITLE="Ensure ufw routed default is configured ((Automated)"
    local EXPECTED="Run the following command and verify that the default policy for routed is disabled or
deny:
# ufw status verbose | awk -F',' '\$1=\"Default\"{print \$3}'
Example output:
disabled (routed)
Important: Any port and protocol will be prevented for being routed."
    local RISK="Unknown"
    local DESC="The default policy for routed traffic determines if UFW forwards traffic between different
network interfaces without requiring specific UFW rules.

Rationale:
A default deny policy ensures that UFW does not forward traffic between different
network interfaces by default. This reduces the risk from unwanted or malicious routed
traffic."
    local ATTACK="Any port and protocol will be prevented for being routed."
    local REMEDIATION="Run the following command to set the default policy for routed to deny:
# ufw default deny routed"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
