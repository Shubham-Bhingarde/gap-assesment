#!/usr/bin/env bash
# controls/2.1.6_ftp_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.6"
    local TITLE="Ensure ftp server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify vsftpd is not installed:
# dpkg-query -l | awk '{print \$2}' | grep -E '^ftp|^tnftp' &>/dev/null &&
echo \"ftp is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify vsftpd service is not enabled:
# systemctl is-enabled vsftpd.service 2>/dev/null | grep 'enabled'
Nothing should be returned.
Run the following command to verify the vsftpd service is not active:
# systemctl is-active vsftpd.service 2>/dev/null | grep '^active'
Nothing should be returned.
Note:
•
•
Other ftp server packages may exist. They should also be audited, if not required
and authorized by local site policy
If the package is required for a dependency:
o Ensure the dependent package is approved by local site policy
o Ensure stopping and masking the service and/or socket meets local site
policy"
    local RISK="Unknown"
    local DESC="The File Transfer Protocol (FTP) provides networked computers with the ability to
transfer files. vsftpd is the Very Secure File Transfer Protocol Daemon.

Rationale:
FTP does not protect the confidentiality of data or authentication credentials. It is
recommended SFTP be used if file transfer is required. Unless there is a need to run
the system as a FTP server (for example, to allow anonymous downloads), it is
recommended that the package be deleted to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the vsftpd package. If the vsftpd
package is removed, these dependent packages will be removed as well. Before
removing the vsftpd package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the vsftpd.service leaving the
vsftpd package installed."
    local REMEDIATION="Run the following commands to stop vsftpd.service and remove the vsftpd
package:
# systemctl stop vsftpd.service
# apt purge vsftpd
- OR - IF - the vsftpd package is required as a dependency:
Run the following commands to stop and mask the vsftpd.service:
# systemctl stop vsftpd.service
# systemctl mask vsftpd.service
Note: Other ftp server packages may exist. If not required and authorized by local site
policy, they should also be removed. If the package is required for a dependency, the
service should be stopped and masked."

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "vsftpd" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="vsftpd package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "vsftpd" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "vsftpd" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="vsftpd is installed, but service vsftpd is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service vsftpd is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="vsftpd is installed and service vsftpd is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
