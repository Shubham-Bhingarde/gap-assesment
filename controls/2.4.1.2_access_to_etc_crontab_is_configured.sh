#!/usr/bin/env bash
# controls/2.4.1.2_access_to_etc_crontab_is_configured.sh

execute_control() {
    local CONTROL_ID="2.4.1.2"
    local TITLE="Ensure access to /etc/crontab is configured ((Automated)"
    local EXPECTED="- IF - cron is installed on the system:
Run the following command and verify Uid and Gid are both 0/root and Access does
not grant permissions to group or other :
# stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab
Access: (600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root)"
    local RISK="Unknown"
    local DESC="The /etc/crontab file is used by cron to control its own jobs. The commands in this
item make sure that root is the user and group owner of the file and that only the owner
can access the file.

Rationale:
This file contains information on what system jobs are run by cron. Write access to
these files could provide unprivileged users with the ability to elevate their privileges.
Read access to these files could provide users with the ability to gain insight on system
jobs that run on the system and could provide them a way to gain unauthorized
privileged access."
    local ATTACK=""
    local REMEDIATION="- IF - cron is installed on the system:
Run the following commands to set ownership and permissions on /etc/crontab:
# chown root:root /etc/crontab
# chmod og-rwx /etc/crontab"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
