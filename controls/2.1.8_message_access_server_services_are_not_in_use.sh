#!/usr/bin/env bash
# controls/2.1.8_message_access_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.8"
    local TITLE="Ensure message access server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify dovecot-imapd and dovecot-pop3d are not
installed:
# dpkg-query -s dovecot-imapd &>/dev/null && echo \"dovecot-imapd is
installed\"
Nothing should be returned.
# dpkg-query -s dovecot-pop3d &>/dev/null && echo \"dovecot-pop3d is
installed\"
Nothing should be returned.
- OR - IF - a package is installed and is required for dependencies:
Run the following commands to verify dovecot.socket and dovecot.service are not
enabled:
# systemctl is-enabled dovecot.socket dovecot.service 2>/dev/null | grep
'enabled'
Nothing should be returned
Run the following command to verify dovecot.socket and dovecot.service are not
active:
# systemctl is-active dovecot.socket dovecot.service 2>/dev/null | grep
'^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="dovecot-imapd and dovecot-pop3d are an open source IMAP and POP3 server for
Linux based systems.

Rationale:
Unless POP3 and/or IMAP servers are to be provided by this system, it is
recommended that the package be removed to reduce the potential attack surface.
Note: Several IMAP/POP3 servers exist and can use other service names. These
should also be audited and the packages removed if not required."
    local ATTACK="There may be packages that are dependent on dovecot-imapd and/or dovecot-pop3d
packages. If dovecot-imapd and dovecot-pop3d packages are removed, these
dependent packages will be removed as well. Before removing dovecot-imapd and/or
dovecot-pop3d packages, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask dovecot.socket and
dovecot.service leaving dovecot-imapd and/or dovecot-pop3d packages installed."
    local REMEDIATION="Run one of the following commands to remove dovecot-imapd and dovecot-pop3d:
Run the following commands to stop dovecot.socket and dovecot.service, and
remove the dovecot-imapd and dovecot-pop3d packages:
# systemctl stop dovecot.socket dovecot.service
# apt purge dovecot-imapd dovecot-pop3d
- OR - IF - a package is installed and is required for dependencies:
Run the following commands to stop and mask dovecot.socket and
dovecot.service:
# systemctl stop dovecot.socket dovecot.service
# systemctl mask dovecot.socket dovecot.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
