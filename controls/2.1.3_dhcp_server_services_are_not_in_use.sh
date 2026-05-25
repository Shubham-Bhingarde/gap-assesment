#!/usr/bin/env bash
# controls/2.1.3_dhcp_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.3"
    local TITLE="Ensure dhcp server services are not in use ((Automated)"
    local EXPECTED="Run the following commands to verify isc-dhcp-server is not installed:
# dpkg-query -s isc-dhcp-server &>/dev/null && echo \"isc-dhcp-server is
installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify isc-dhcp-server.service and isc-dhcpserver6.service are not enabled:
# systemctl is-enabled isc-dhcp-server.service isc-dhcp-server6.service
2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify isc-dhcp-server.service and isc-dhcpserver6.service are not active:
# systemctl is-active isc-dhcp-server.service isc-dhcp-server6.service
2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Dynamic Host Configuration Protocol (DHCP) is a service that allows machines to
be dynamically assigned IP addresses. There are two versions of the DHCP protocol
DHCPv4 and DHCPv6. At startup the server may be started for one or the other via the -4
or -6 arguments.

Rationale:
Unless a system is specifically set up to act as a DHCP server, it is recommended that
this package be removed to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the isc-dhcp-server package. If the
isc-dhcp-server package is removed, these dependent packages will be removed as
well. Before removing the isc-dhcp-server package, review any dependent packages
to determine if they are required on the system.
- IF - a dependent package is required: stop and mask the isc-dhcp-server.service
and isc-dhcp-server6.service leaving the isc-dhcp-server package installed."
    local REMEDIATION="Run the following commands to stop isc-dhcp-server.service and isc-dhcpserver6.service and remove the isc-dhcp-server package:
# systemctl stop isc-dhcp-server.service isc-dhcp-server6.service
# apt purge isc-dhcp-server
- OR - IF - the isc-dhcp-server package is required as a dependency:
Run the following commands to stop and mask isc-dhcp-server.service and iscdhcp-server6.service:
# systemctl stop isc-dhcp-server.service isc-dhcp-server6.service
# systemctl mask isc-dhcp-server isc-dhcp-server6.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
