#!/usr/bin/env bash
# controls/6.1.1.2.4_systemd_journal_remote_service_is_not_in_use.sh

execute_control() {
    local CONTROL_ID="6.1.1.2.4"
    local TITLE="Ensure systemd-journal-remote service is not in use ((Automated)"
    local EXPECTED="Run the following command to verify systemd-journal-remote.socket and systemdjournal-remote.service are not enabled:
# systemctl is-enabled systemd-journal-remote.socket systemd-journalremote.service | grep -P -- '^enabled'
Nothing should be returned
Run the following command to verify systemd-journal-remote.socket and systemdjournal-remote.service are not active:
# systemctl is-active systemd-journal-remote.socket systemd-journalremote.service | grep -P -- '^active'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="Journald systemd-journal-remote supports the ability to receive messages from
remote hosts, thus acting as a log server. Clients should not receive data from other
hosts.
Note:
•
•
The same package, systemd-journal-remote, is used for both sending logs to
remote hosts and receiving incoming logs.
With regards to receiving logs, there are two services; systemd-journalremote.socket and systemd-journal-remote.service.

Rationale:
If a client is configured to also receive data, thus turning it into a server, the client
system is acting outside it's operational boundary.
Note: This recommendation only applies if journald is the chosen method for
client side logging. Do not apply this recommendation if rsyslog is used."
    local ATTACK=""
    local REMEDIATION="Run the following commands to stop and mask systemd-journal-remote.socket and
systemd-journal-remote.service:
# systemctl stop systemd-journal-remote.socket systemd-journal-remote.service
# systemctl mask systemd-journal-remote.socket systemd-journal-remote.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
