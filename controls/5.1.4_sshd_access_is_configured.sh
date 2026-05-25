#!/usr/bin/env bash
# controls/5.1.4_sshd_access_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.4"
    local TITLE="Ensure sshd access is configured ((Automated)"
    local EXPECTED="Run the following command and verify the output:
# sshd -T | grep -Pi -- '^\h*(allow|deny)(users|groups)\h+\H+'
Verify that the output matches at least one of the following lines:
allowusers <userlist>
-ORallowgroups <grouplist>
-ORdenyusers <userlist>
-ORdenygroups <grouplist>
Review the list(s) to ensure included users and/or groups follow local site policy
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep -Pi -'^\h*(allow|deny)(users|groups)\h+\H+'
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain)."
    local RISK="Unknown"
    local DESC="There are several options available to limit which users and group can access the
system via SSH. It is recommended that at least one of the following options be
leveraged:
•
•
•
•
AllowUsers:
o The AllowUsers variable gives the system administrator the option of
allowing specific users to ssh into the system. The list consists of space
separated user names. Numeric user IDs are not recognized with this
variable. If a system administrator wants to restrict user access further by
only allowing the allowed users to log in from a particular host, the entry
can be specified in the form of user@host.
AllowGroups:
o The AllowGroups variable gives the system administrator the option of
allowing specific groups of users to ssh into the system. The list consists
of space separated group names. Numeric group IDs are not recognized
with this variable.
DenyUsers:
o The DenyUsers variable gives the system administrator the option of
denying specific users to ssh into the system. The list consists of space
separated user names. Numeric user IDs are not recognized with this
variable. If a system administrator wants to restrict user access further by
specifically denying a user's access from a particular host, the entry can
be specified in the form of user@host.
DenyGroups:
o The DenyGroups variable gives the system administrator the option of
denying specific groups of users to ssh into the system. The list consists
of space separated group names. Numeric group IDs are not recognized
with this variable.

Rationale:
Restricting which users can remotely access the system via SSH will help ensure that
only authorized users access the system."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set one or more of the parameters above any
Include and Match set statements as follows:
AllowUsers <userlist>
- AND/OR AllowGroups <grouplist>
Note:
•
•
•
First occurrence of a option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a .conf file in a
Include directory.
Be advised that these options are \"ANDed\" together. If both AllowUsers and
AllowGroups are set, connections will be limited to the list of users that are also
a member of an allowed group. It is recommended that only one be set for clarity
and ease of administration.
It is easier to manage an allow list than a deny list. In a deny list, you could
potentially add a user or group and forget to add it to the deny list."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
