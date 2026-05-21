#!/usr/bin/env bash
# controls/6.1.1.2.1_systemd_journal_remote_is_installed.sh

execute_control() {
    local CONTROL_ID="6.1.1.2.1"
    local TITLE="Ensure systemd-journal-remote is installed ((Automated)"
    local EXPECTED="- IF - journald will be used for logging on the system:
Run the following command to verify systemd-journal-remote is installed.
# dpkg-query -s systemd-journal-remote &>/dev/null && echo \"systemd-journalremote is installed\"
Verify the output matches:
systemd-journal-remote is installed"
    local RISK="Unknown"
    local DESC="Journald systemd-journal-remote supports the ability to send log events it gathers to
a remote log host or to receive messages from remote hosts, thus enabling centralized
log management.

Rationale:
Storing log data on a remote host protects log integrity from local attacks. If an attacker
gains root access on the local system, they could tamper with or remove log data that is
stored on the local system.
Note: This recommendation only applies if journald is the chosen method for
client side logging. Do not apply this recommendation if rsyslog is used."
    local ATTACK=""
    local REMEDIATION="Run the following command to install systemd-journal-remote:
# apt install systemd-journal-remote"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
