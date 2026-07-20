#!/usr/bin/env bash
# controls/2.1.16_tftp_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.16"
    local TITLE="Ensure tftp server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify tftpd-hpa is not installed:
# dpkg-query -s tftpd-hpa &>/dev/null && echo \"tftpd-hpa is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify tftpd-hpa.service is not enabled:
# systemctl is-enabled tftpd-hpa.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the tftpd-hpa.service is not active:
# systemctl is-active tftpd-hpa.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="Trivial File Transfer Protocol (TFTP) is a simple protocol for exchanging files between
two TCP/IP machines. TFTP servers allow connections from a TFTP Client for sending
and receiving files.

Rationale:
Unless there is a need to run the system as a TFTP server, it is recommended that the
package be removed to reduce the potential attack surface.
TFTP does not have built-in encryption, access control or authentication. This makes it
very easy for an attacker to exploit TFTP to gain access to files"
    local ATTACK="TFTP is often used to provide files for network booting such as for PXE based
installation of servers.
There may be packages that are dependent on the tftpd-hpa package. If the tftpdhpa package is removed, these dependent packages will be removed as well. Before
removing the tftpd-hpa package, review any dependent packages to determine if they
are required on the system.
- IF - a dependent package is required: stop and mask tftpd-hpa.service leaving the
tftpd-hpa package installed."
    local REMEDIATION="Run the following commands to stop tftpd-hpa.service, and remove the tftpd-hpa
package:
# systemctl stop tftpd-hpa.service
# apt purge tftpd-hpa
- OR - IF - the tftpd-hpa package is required as a dependency:
Run the following commands to stop and mask tftpd-hpa.service:
# systemctl stop tftpd-hpa.service
# systemctl mask tftpd-hpa.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "tftpd-hpa" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="tftpd-hpa package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "tftpd-hpa" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "tftpd-hpa" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="tftpd-hpa is installed, but service tftpd-hpa is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service tftpd-hpa is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="tftpd-hpa is installed and service tftpd-hpa is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
