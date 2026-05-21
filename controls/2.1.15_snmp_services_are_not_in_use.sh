#!/usr/bin/env bash
# controls/2.1.15_snmp_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.15"
    local TITLE="Ensure snmp services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify snmpd is not installed:
# dpkg-query -s snmpd &>/dev/null && echo \"snmpd is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify the snmpd.service is not enabled:
# systemctl is-enabled snmpd.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the snmpd.service is not active:
# systemctl is-active snmpd.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="Simple Network Management Protocol (SNMP) is a widely used protocol for monitoring
the health and welfare of network equipment, computer equipment and devices like
UPSs.
Net-SNMP is a suite of applications used to implement SNMPv1 (RFC 1157), SNMPv2
(RFCs 1901-1908), and SNMPv3 (RFCs 3411-3418) using both IPv4 and IPv6.
Support for SNMPv2 classic (a.k.a. \"SNMPv2 historic\" - RFCs 1441-1452) was dropped
with the 4.0 release of the UCD-snmp package.
The Simple Network Management Protocol (SNMP) server is used to listen for SNMP
commands from an SNMP management system, execute the commands or collect the
information and then send results back to the requesting system.

Rationale:
The SNMP server can communicate using SNMPv1, which transmits data in the clear
and does not require authentication to execute commands. SNMPv3 replaces the
simple/clear text password sharing used in SNMPv2 with more securely encoded
parameters. If the the SNMP service is not required, the snmpd package should be
removed to reduce the attack surface of the system.
Note: If SNMP is required:
•
•
The server should be configured for SNMP v3 only. User Authentication and
Message Encryption should be configured.
If SNMP v2 is absolutely necessary, modify the community strings' values."
    local ATTACK="There may be packages that are dependent on the snmpd package. If the snmpd
package is removed, these packages will be removed as well.
Before removing the snmpd package, review any dependent packages to determine if
they are required on the system. If a dependent package is required, stop and mask the
snmpd.service leaving the snmpd package installed."
    local REMEDIATION="Run the following commands to stop snmpd.service and remove the snmpd package:
# systemctl stop snmpd.service
# apt purge snmpd
- OR - If the package is required for dependencies:
Run the following commands to stop and mask the snmpd.service:
# systemctl stop snmpd.service
# systemctl mask snmpd.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
