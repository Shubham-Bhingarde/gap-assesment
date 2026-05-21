#!/usr/bin/env bash
# controls/2.1.10_nis_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.10"
    local TITLE="Ensure nis server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify ypserv is not installed:
# dpkg-query -s ypserv &>/dev/null && echo \"ypserv is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify ypserv.service is not enabled:
# systemctl is-enabled ypserv.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify ypserv.service is not active:
# systemctl is-active ypserv.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Network Information Service (NIS) (formally known as Yellow Pages) is a clientserver directory service protocol for distributing system configuration files. The NIS
server is a collection of programs that allow for the distribution of configuration files. The
NIS client (ypbind) was used to bind a machine to an NIS server and receive the
distributed configuration files.

Rationale:
ypserv.service is inherently an insecure system that has been vulnerable to DOS
attacks, buffer overflows and has poor authentication for querying NIS maps. NIS
generally has been replaced by such protocols as Lightweight Directory Access
Protocol (LDAP). It is recommended that ypserv.service be removed and other, more
secure services be used"
    local ATTACK="There may be packages that are dependent on the ypserv package. If the ypserv
package is removed, these dependent packages will be removed as well. Before
removing the ypserv package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the ypserv.service leaving the
ypserv package installed."
    local REMEDIATION="Run the following commands to stop ypserv.service and remove ypserv package:
# systemctl stop ypserv.service
# apt purge ypserv
- OR - IF - the ypserv package is required as a dependency:
Run the following commands to stop and mask ypserv.service:
# systemctl stop ypserv.service
# systemctl mask ypserv.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
