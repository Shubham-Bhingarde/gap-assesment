#!/usr/bin/env bash
# controls/4.1.3_ufw_incoming_default_is_configured.sh

execute_control() {
    local CONTROL_ID="4.1.3"
    local TITLE="Ensure ufw incoming default is configured ((Automated)"
    local EXPECTED="Run the following command to verify that the default policy for incoming is deny or
reject:
# ufw status verbose | awk -F',' '\$1~/Default/ {print \$1}'
Example output:
Default: deny (incoming)"
    local RISK="Unknown"
    local DESC="The default policy for incoming traffic determines if connections attempting to reach your
server from external sources will be allowed without requiring specific UFW rules.

Rationale:
With a default accept policy the firewall will accept any packet that is not configured to
be denied. It is easier to allow list acceptable usage than to deny list unacceptable
usage."
    local ATTACK="Any port or protocol without a explicit allow before the default deny will be blocked. A
deny policy silently drops packs causing an eventual time out with no response while a
'reject' policy sends an immediate and explicit \"connection refused\" or \"destination
unreachable\" message in response.
The following is and example of a command to create a rule to allow connection to the
ssh server on the host. This rule should be considered before applying the default deny.
Example:
# ufw allow ssh"
    local REMEDIATION="Run the following command to set the default for incoming to deny:
# ufw default deny incoming
Warning: Any port or protocol without a explicit allow before the default deny will be
blocked."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
