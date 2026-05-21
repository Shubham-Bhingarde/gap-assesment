#!/usr/bin/env bash
# controls/2.1.14_samba_file_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.14"
    local TITLE="Ensure samba file server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify samba is not installed:
# dpkg-query -s samba &>/dev/null && echo \"samba is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify smbd.service is not enabled:
# systemctl is-enabled smbd.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the smbd.service is not active:
# systemctl is-active smbd.service 2>/dev/null | grep '^active'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The Samba daemon allows system administrators to configure their Linux systems to
share file systems and directories with Windows desktops. Samba will advertise the file
systems and directories via the Server Message Block (SMB) protocol. Windows
desktop users will be able to mount these directories and file systems as letter drives on
their systems.

Rationale:
If there is no need to mount directories and file systems to Windows systems, then this
service should be deleted to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the samba package. If the samba
package is removed, these dependent packages will be removed as well. Before
removing the samba package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the smbd.service leaving the
samba package installed."
    local REMEDIATION="Run the following commands to stop smbd.service and remove samba package:
# systemctl stop smbd.service
# apt purge samba
- OR - IF - the samba package is required as a dependency:
Run the following commands to stop and mask the smbd.service:
# systemctl stop smbd.service
# systemctl mask smbd.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
