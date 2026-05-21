#!/usr/bin/env bash
# controls/4.1.4_ufw_outgoing_default_is_configured.sh

execute_control() {
    local CONTROL_ID="4.1.4"
    local TITLE="Ensure ufw outgoing default is configured ((Automated)"
    local EXPECTED="Run the following command and verify that the default policy for outgoing is deny or
reject:
# ufw status verbose | awk -F',' '\$1~/Default/ {print \$2}'
Example output:
deny (outgoing)"
    local RISK="Unknown"
    local DESC="The default policy for outgoing traffic determines if applications and services running on
your server can initiate connections to external networks without requiring specific UFW
rules.

Rationale:
With a default deny outgoing policy the firewall will deny ALL outgoing traffic and is a
highly restrictive policy that requires the addition of specific allow rules."
    local ATTACK="Any port and protocol not explicitly allowed will be blocked. The following rules are an
example of some outgoing allow rules that should be considered before applying this
default deny.
ufw allow out http
ufw allow out https
ufw allow out ntp # Network Time Protocol
ufw allow out to any port 53 # DNS
ufw allow out to any port 853 # DNS over TLS
ufw logging on"
    local REMEDIATION="Run the following command to set the default for outgoing to deny:
# ufw default deny outgoing
Warning: Any port or protocol without a explicit allow before the default deny will be
blocked."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
