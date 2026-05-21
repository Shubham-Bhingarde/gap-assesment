#!/usr/bin/env bash
# controls/2.1.5_dnsmasq_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.5"
    local TITLE="Ensure dnsmasq services are not in use ((Automated)"
    local EXPECTED="Run one of the following commands to verify dnsmasq is not installed:
# dpkg-query -s dnsmasq &>/dev/null && echo \"dnsmasq is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify dnsmasq.service is not enabled:
# systemctl is-enabled dnsmasq.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the dnsmasq.service is not active:
# systemctl is-active dnsmasq.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="dnsmasq is a lightweight tool that provides DNS caching, DNS forwarding and DHCP
(Dynamic Host Configuration Protocol) services.

Rationale:
Unless a system is specifically designated to act as a DNS caching, DNS forwarding
and/or DHCP server, it is recommended that the package be removed to reduce the
potential attack surface."
    local ATTACK="There may be packages that are dependent on the dnsmasq package. If the dnsmasq
package is removed, these dependent packages will be removed as well. Before
removing the dnsmasq package, review any dependent packages to determine if they
are required on the system.
- IF - a dependent package is required: stop and mask the dnsmasq.service leaving
the dnsmasq package installed."
    local REMEDIATION="Run the following commands to stop dnsmasq.service and remove dnsmasq package:
# systemctl stop dnsmasq.service
# apt purge dnsmasq
- OR - IF - the dnsmasq package is required as a dependency:
Run the following commands to stop and mask the dnsmasq.service:
# systemctl stop dnsmasq.service
# systemctl mask dnsmasq.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
