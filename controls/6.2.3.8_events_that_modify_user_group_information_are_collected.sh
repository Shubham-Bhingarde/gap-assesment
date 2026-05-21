#!/usr/bin/env bash
# controls/6.2.3.8_events_that_modify_user_group_information_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.8"
    local TITLE="Ensure events that modify user/group information are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# awk '/^ *-w/ \
&&(/\/etc\/group/ \
||/\/etc\/passwd/ \
||/\/etc\/gshadow/ \
||/\/etc\/shadow/ \
||/\/etc\/security\/opasswd/ \
||/\/etc\/nsswitch.conf/ \
||/\/etc\/pam.conf/ \
||/\/etc\/pam.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
Verify the output matches:
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
-w /etc/nsswitch.conf -p wa -k identity
-w /etc/pam.conf -p wa -k identity
-w /etc/pam.d -p wa -k identity
Running configuration
Run the following command to check loaded rules:
# auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/group/ \
||/\/etc\/passwd/ \
||/\/etc\/gshadow/ \
||/\/etc\/shadow/ \
||/\/etc\/security\/opasswd/ \
||/\/etc\/nsswitch.conf/ \
||/\/etc\/pam.conf/ \
||/\/etc\/pam.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
Verify the output matches:
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
-w /etc/nsswitch.conf -p wa -k identity
-w /etc/pam.conf -p wa -k identity
-w /etc/pam.d -p wa -k identity"
    local RISK="Unknown"
    local DESC="Record events affecting the modification of user or group information, including that of
passwords and old passwords if in use.
•
•
•
•
•
•
•
•
/etc/group - system groups
/etc/passwd - system users
/etc/gshadow - encrypted password for each group
/etc/shadow - system user passwords
/etc/security/opasswd - storage of old passwords if the relevant PAM module
is in use
/etc/nsswitch.conf - file configures how the system uses various databases
and name resolution mechanisms
/etc/pam.conf - file determines the authentication services to be used, and the
order in which the services are used.
/etc/pam.d - directory contains the PAM configuration files for each PAM-aware
application.
The parameters in this section will watch the files to see if they have been opened for
write or have had attribute changes (e.g. permissions) and tag them with the identifier
\"identity\" in the audit log file.

Rationale:
Unexpected changes to these files could be an indication that the system has been
compromised and that an unauthorized user is attempting to hide their activities or
compromise additional accounts."
    local ATTACK=""
    local REMEDIATION="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor events that modify user/group information.
Example:
# printf \"
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
-w /etc/nsswitch.conf -p wa -k identity
-w /etc/pam.conf -p wa -k identity
-w /etc/pam.d -p wa -k identity
\" >> /etc/audit/rules.d/50-identity.rules
Merge and load the rules into active configuration:
# augenrules --load
Check if reboot is required.
# if [[ \$(auditctl -s | grep \"enabled\") =~ \"2\" ]]; then printf \"Reboot
required to load rules\n\"; fi"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
