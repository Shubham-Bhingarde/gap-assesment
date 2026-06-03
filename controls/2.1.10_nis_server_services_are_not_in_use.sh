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

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "nis" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="nis package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "ypserv" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "ypserv" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="nis is installed, but service ypserv is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service ypserv is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="nis is installed and service ypserv is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
