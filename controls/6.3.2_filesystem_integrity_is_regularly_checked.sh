#!/usr/bin/env bash
# controls/6.3.2_filesystem_integrity_is_regularly_checked.sh

execute_control() {
    local CONTROL_ID="6.3.2"
    local TITLE="Ensure filesystem integrity is regularly checked ((Automated)"
    local EXPECTED="Run the following commands to verify a cron job scheduled to run the aide check.
# grep -Prs '^([^#\n\r]+\h+)?(\/usr\/s?bin\/|^\h*)aide(\.wrapper)?\h+(-(check|update)|([^#\n\r]+\h+)?\$AIDEARGS)\b' /etc/cron.* /etc/crontab
/var/spool/cron/
Ensure a cron job in compliance with site policy is returned.
- OR Run the following commands to verify that aidecheck.service and aidecheck.timer
are enabled and aidecheck.timer is running
# systemctl is-enabled aidecheck.service
# systemctl is-enabled aidecheck.timer
# systemctl status aidecheck.timer"
    local RISK="Unknown"
    local DESC="Periodic checking of the filesystem integrity is needed to detect changes to the
filesystem.

Rationale:
Periodic file checking allows the system administrator to determine on a regular basis if
critical files have been changed in an unauthorized fashion."
    local ATTACK=""
    local REMEDIATION="If cron will be used to schedule and run aide check:
Run the following command:
# crontab -u root -e
Add the following line to the crontab:
0 5 * * * /usr/bin/aide.wrapper --config /etc/aide/aide.conf --update
- OR - If aidecheck.service and aidecheck.timer will be used to schedule and run aide
check:
Create or edit the file /etc/systemd/system/aidecheck.service and add the
following lines:
[Unit]
Description=Aide Check
[Service]
Type=simple
ExecStart=/usr/bin/aide.wrapper --config /etc/aide/aide.conf --update
[Install]
WantedBy=multi-user.target
Create or edit the file /etc/systemd/system/aidecheck.timer and add the following
lines:
[Unit]
Description=Aide check every day at 5AM
[Timer]
OnCalendar=*-*-* 05:00:00
Unit=aidecheck.service
[Install]
WantedBy=multi-user.target
Run the following commands:
# chown root:root /etc/systemd/system/aidecheck.*
# chmod 0644 /etc/systemd/system/aidecheck.*
# systemctl daemon-reload
# systemctl enable aidecheck.service
# systemctl --now enable aidecheck.timer"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
