#!/usr/bin/env bash
# controls/2.1.4_dns_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.4"
    local TITLE="Ensure dns server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify bind9 is not installed:
# dpkg-query -s bind9 &>/dev/null && echo \"bind9 is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify named.service is not enabled:
# systemctl is-enabled named.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the named.service is not active:
# systemctl is-active named.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Domain Name System (DNS) is a hierarchical naming system that maps names to
IP addresses for computers, services and other resources connected to a network.
Note: bind9 is the package and bind.service is the alias for named.service.

Rationale:
Unless a system is specifically designated to act as a DNS server, it is recommended
that the package be deleted to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the bind9 package. If the bind9
package is removed, these dependent packages will be removed as well. Before
removing the bind9 package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask named.service leaving the
bind9 package installed."
    local REMEDIATION="Run the following commands to stop named.service and remove the bind9 package:
# systemctl stop named.service
# apt purge bind9
- OR - IF - the bind9 package is required as a dependency:
Run the following commands to stop and mask bind9.service:
# systemctl stop named.service
# systemctl mask named.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
