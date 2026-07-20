#!/usr/bin/env bash
# controls/2.1.12_rpcbind_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.12"
    local TITLE="Ensure rpcbind services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify rpcbind package is not installed:
# dpkg-query -s rpcbind &>/dev/null && echo \"rpcbind is installed\"
Nothing should be returned.
- OR - IF - the rpcbind package is required as a dependency:
Run the following command to verify rpcbind.socket and rpcbind.service are not
enabled:
# systemctl is-enabled rpcbind.socket rpcbind.service 2>/dev/null | grep
'enabled'
Nothing should be returned
Run the following command to verify rpcbind.socket and rpcbind.service are not
active:
# systemctl is-active rpcbind.socket rpcbind.service 2>/dev/null | grep
'^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The rpcbind utility maps RPC services to the ports on which they listen. RPC
processes notify rpcbind when they start, registering the ports they are listening on and
the RPC program numbers they expect to serve. The client system then contacts
rpcbind on the server with a particular RPC program number. The rpcbind.service
redirects the client to the proper port number so it can communicate with the requested
service.
Portmapper is an RPC service, which always listens on tcp and udp 111, and is used to
map other RPC services (such as nfs, nlockmgr, quotad, mountd, etc.) to their
corresponding port number on the server. When a remote host makes an RPC call to
that server, it first consults with portmap to determine where the RPC server is listening.

Rationale:
A small request (~82 bytes via UDP) sent to the Portmapper generates a large
response (7x to 28x amplification), which makes it a suitable tool for DDoS attacks. If
rpcbind is not required, it is recommended to remove rpcbind package to reduce the
potential attack surface."
    local ATTACK="Many of the libvirt packages used by Enterprise Linux virtualization, and the nfs-utils
package used for The Network File System (NFS), are dependent on the rpcbind
package. If the rpcbind package is removed, these dependent packages will be
removed as well. Before removing the rpcbind package, review any dependent
packages to determine if they are required on the system.
- IF - a dependent package is required: stop and mask the rpcbind.socket and
rpcbind.service leaving the rpcbind package installed."
    local REMEDIATION="Run the following commands to stop rpcbind.socket and rpcbind.service, and
remove the rpcbind package:
# systemctl stop rpcbind.socket rpcbind.service
# apt purge rpcbind
- OR - IF - the rpcbind package is required as a dependency:
Run the following commands to stop and mask the rpcbind.socket and
rpcbind.service:
# systemctl stop rpcbind.socket rpcbind.service
# systemctl mask rpcbind.socket rpcbind.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "rpcbind" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="rpcbind package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "rpcbind" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "rpcbind" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="rpcbind is installed, but service rpcbind is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service rpcbind is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="rpcbind is installed and service rpcbind is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
