#!/usr/bin/env bash
# controls/2.1.7_ldap_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.7"
    local TITLE="Ensure ldap server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify slapd is not installed:
# dpkg-query -s slapd &>/dev/null && echo \"slapd is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify slapd.service is not enabled:
# systemctl is-enabled slapd.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify slapd.service is not active:
# systemctl is-active slapd.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for
NIS/YP. It is a service that provides a method for looking up information from a central
database.

Rationale:
If the system will not need to act as an LDAP server, it is recommended that the
software be removed to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the slapd package. If the slapd
package is removed, these dependent packages will be removed as well. Before
removing the slapd package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the slapd.service leaving the
slapd package installed."
    local REMEDIATION="Run the following commands to stop slapd.service and remove the slapd package:
# systemctl stop slapd.service
# apt purge slapd
- OR - IF - the slapd package is required as a dependency:
Run the following commands to stop and mask slapd.service:
# systemctl stop slapd.service
# systemctl mask slapd.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
