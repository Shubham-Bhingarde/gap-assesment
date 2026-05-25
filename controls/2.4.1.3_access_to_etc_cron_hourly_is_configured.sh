#!/usr/bin/env bash
# controls/2.4.1.3_access_to_etc_cron_hourly_is_configured.sh

execute_control() {
    local CONTROL_ID="2.4.1.3"
    local TITLE="Ensure access to /etc/cron.hourly is configured ((Automated)"
    local EXPECTED="- IF - cron is installed on the system:
Run the following command and verify Uid and Gid are both 0/root and Access does
not grant permissions to group or other:
# stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.hourly/
Access: (700/drwx------) Uid: ( 0/ root) Gid: ( 0/ root)"
    local RISK="Unknown"
    local DESC="This directory contains system cron jobs that need to run on an hourly basis. The files
in this directory cannot be manipulated by the crontab command, but are instead
edited by system administrators using a text editor. The commands below restrict
read/write and search access to user and group root, preventing regular users from
accessing this directory.

Rationale:
Granting write access to this directory for non-privileged users could provide them the
means for gaining unauthorized elevated privileges. Granting read access to this
directory could give an unprivileged user insight in how to gain elevated privileges or
circumvent auditing controls."
    local ATTACK=""
    local REMEDIATION="- IF - cron is installed on the system:
Run the following commands to set ownership and permissions on the
/etc/cron.hourly directory:
# chown root:root /etc/cron.hourly/
# chmod og-rwx /etc/cron.hourly/"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
