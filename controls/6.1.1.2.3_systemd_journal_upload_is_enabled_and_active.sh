#!/usr/bin/env bash
# controls/6.1.1.2.3_systemd_journal_upload_is_enabled_and_active.sh

execute_control() {
    local CONTROL_ID="6.1.1.2.3"
    local TITLE="Ensure systemd-journal-upload is enabled and active ((Automated)"
    local EXPECTED="Run the following command to verify systemd-journal-upload is enabled.
# systemctl is-enabled systemd-journal-upload.service
enabled
Run the following command to verify systemd-journal-upload is active:
# systemctl is-active systemd-journal-upload.service
active"
    local RISK="Unknown"
    local DESC="Journald systemd-journal-upload supports the ability to send log events it gathers to
a remote log host.

Rationale:
Storing log data on a remote host protects log integrity from local attacks. If an attacker
gains root access on the local system, they could tamper with or remove log data that is
stored on the local system."
    local ATTACK=""
    local REMEDIATION="Run the following commands to unmask, enable and start systemd-journal-upload:
# systemctl unmask systemd-journal-upload.service
# systemctl --now enable systemd-journal-upload.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
