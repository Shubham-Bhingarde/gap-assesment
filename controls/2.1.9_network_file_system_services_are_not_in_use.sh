#!/usr/bin/env bash
# controls/2.1.9_network_file_system_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.9"
    local TITLE="Ensure network file system services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify nfs-kernel-server is not installed:
# dpkg-query -s nfs-kernel-server &>/dev/null && echo \"nfs-kernel-server is
installed\"
Nothing should be returned.
- OR - IF - package is required for dependencies:
Run the following command to verify that the nfs-server.service is not enabled:
# systemctl is-enabled nfs-server.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the nfs-server.service is not active:
# systemctl is-active nfs-server.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
• Ensure the dependent package is approved by local site policy
• Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Network File System (NFS) is one of the first and most widely distributed file
systems in the UNIX environment. It provides the ability for systems to mount file
systems of other servers through the network.

Rationale:
If the system does not export NFS shares, it is recommended that the nfs-kernelserver package be removed to reduce the remote attack surface."
    local ATTACK="There may be packages that are dependent on the nfs-kernel-server package. If the
nfs-kernel-server package is removed, these dependent packages will be removed
as well. Before removing the nfs-kernel-server package, review any dependent
packages to determine if they are required on the system.
- IF - a dependent package is required: stop and mask the nfs-server.service
leaving the nfs-kernel-server package installed."
    local REMEDIATION="Run the following command to stop nfs-server.service and remove nfs-kernelserver package:
# systemctl stop nfs-server.service
# apt purge nfs-kernel-server
- OR - IF - the nfs-kernel-server package is required as a dependency:
Run the following commands to stop and mask the nfs-server.service:
# systemctl stop nfs-server.service
# systemctl mask nfs-server.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "nfs-kernel-server" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="nfs-kernel-server package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "nfs-kernel-server" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "nfs-kernel-server" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="nfs-kernel-server is installed, but service nfs-kernel-server is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service nfs-kernel-server is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="nfs-kernel-server is installed and service nfs-kernel-server is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
