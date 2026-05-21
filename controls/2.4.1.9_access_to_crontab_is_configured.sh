#!/usr/bin/env bash
# controls/2.4.1.9_access_to_crontab_is_configured.sh

execute_control() {
    local CONTROL_ID="2.4.1.9"
    local TITLE="Ensure access to crontab is configured ((Automated)"
    local EXPECTED="- IF - cron is installed on the system:
Run the following command to verify /etc/cron.allow:
•
•
•
•
Exists
Is mode 0640 or more restrictive
Is owned by the user root
Is group owned by the group root - OR - the group crontab
# stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.allow
Verify the returned value is:
Access: (640/-rw-r-----) Owner: (root) Group: (root)
- OR Access: (640/-rw-r-----) Owner: (root) Group: (crontab)
Run the following command to verify either cron.deny doesn't exist or is:
•
•
•
Mode 0640 or more restrictive
Owned by the user root
Is group owned by the group root - OR - the group crontab
# [ -e \"/etc/cron.deny\" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group:
(%G)' /etc/cron.deny
Verify either nothing is returned - OR - returned value is one of the following:
Access: (640/-rw-r-----) Owner: (root) Group: (root)
- OR Access: (640/-rw-r-----) Owner: (root) Group: (crontab)
Note: On systems where cron is configured to use the group crontab, if the group
crontab is not set as the owner of cron.allow, then cron will deny access to all users
and you will see an error similar to:
You (<USERNAME>) are not allowed to use this program (crontab)
See crontab(1) for more information"
    local RISK="Unknown"
    local DESC="crontab is the program used to install, deinstall, or list the tables used to drive the cron
daemon. Each user can have their own crontab, and though files are created, they are
not intended to be edited directly.
If the /etc/cron.allow file exists, then you must be listed (one user per line) therein in
order to be allowed to use this command. If the /etc/cron.allow file does not exist but
the /etc/cron.deny file does exist, then you must not be listed in the /etc/cron.deny
file in order to use this command.
If neither of these files exists, then depending on site-dependent configuration
parameters, only the super user will be allowed to use this command, or all users will be
able to use this command.
If both files exist then /etc/cron.allow takes precedence. Which means that
/etc/cron.deny is not considered and your user must be listed in /etc/cron.allow
in order to be able to use the crontab.
Regardless of the existence of any of these files, the root administrative user is always
allowed to setup a crontab.
The files /etc/cron.allow and /etc/cron.deny, if they exist, must be either worldreadable, or readable by group crontab. If they are not, then cron will deny access to
all users until the permissions are fixed.
There is one file for each user's crontab. Users are not allowed to edit the file directly to
ensure that only users allowed by the system to run periodic tasks can add them, and
only syntactically correct crontabs will be written. This is enforced by having the
directory writable only by the crontab group and configuring crontab command with the
setgid bid set for that specific group.
Note:
•
•
The files /etc/cron.allow and /etc/cron.deny, if they exist, only controls
administrative access to the crontab command for scheduling and modifying cron
jobs
If you are using SELinux or AppArmor, these security modules may prevent
crontab access. Check the audit logs for any related permission denied entries
and adjust your policies if necessary.

Rationale:
On many systems, only the system administrator is authorized to schedule cron jobs.
Using the cron.allow file to control who can run cron jobs enforces this policy. It is
easier to manage an allow list than a deny list. In a deny list, you could potentially add a
user ID to the system and forget to add it to the deny files."
    local ATTACK="When the /etc/cron.allow file exists, a user must be listed, one user per line, in the
/etc/cron.allow file in order to be allowed to use the crontab command."
    local REMEDIATION="- IF - cron is installed on the system:
Run the following script to:
•
•
•
•
Create /etc/cron.allow if it doesn't exist
Change owner to user root
Change group owner to group root - OR - group crontab if it exists
Change mode to 640 or more restrictive
#!/usr/bin/env bash
{
[ ! -e \"/etc/cron.allow\" ] && touch /etc/cron.allow
chmod u-x,g-wx,o-rwx /etc/cron.allow
if grep -Pq -- '^\h*crontab\:' /etc/group; then
chown root:crontab /etc/cron.allow
else
chown root:root /etc/cron.allow
fi
}
- IF - /etc/cron.deny exists, run the following script to:
•
•
•
Change owner to user root
Change group owner to group root - OR - group crontab if it exists
Change mode to 640 or more restrictive
#!/usr/bin/env bash
{
if [ -e \"/etc/cron.deny\" ]; then
chmod u-x,g-wx,o-rwx /etc/cron.deny
if grep -Pq -- '^\h*crontab\:' /etc/group; then
chown root:crontab /etc/cron.deny
else
chown root:root /etc/cron.deny
fi
fi
}
Note:
•
•
•
•
•
When the /etc/cron.allow file exists, a user must be listed, one user per
line, in the /etc/cron.allow file in order to be allowed to use the crontab
command.
If both /etc/cron.allow and /etc/cron.deny exist, /etc/cron.allow takes
precedence. Which means that /etc/cron.deny is not considered and users
must be listed in /etc/cron.allow in order to use the crontab.
If the /etc/cron.allow file does not exist but the /etc/cron.deny file does
exist, then you must not be listed in the /etc/cron.deny file in order to use the
crontab command.
Regardless of the existence of any of these files, the root administrative user is
always allowed to setup a crontab.
On systems where cron is configured to use the group crontab, if the group
crontab is not set as the owner of /etc/cron.allow, then cron will deny access
to all users but root, and you will see an error similar to:
You (<USERNAME>) are not allowed to use this program (crontab)
See crontab(1) for more information"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
