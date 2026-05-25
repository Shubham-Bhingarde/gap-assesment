#!/usr/bin/env bash
# controls/5.4.1.6_inactive_password_lock_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.1.6"
    local TITLE="Ensure inactive password lock is configured ((Automated)"
    local EXPECTED="Run the following script and verify nothing is returned:
#!/usr/bin/env bash
{
while IFS= read -r l_user; do
l_change=\$(date -d \"\$(chage --list \$l_user | grep '^Last password
change' | cut -d: -f2 | grep -v 'never\$')\" +%s)
if [[ \"\$l_change\" -gt \"\$(date +%s)\" ]]; then
echo \"User: \\\"\$l_user\\\" last password change was \\\"\$(chage --list
\$l_user | grep '^Last password change' | cut -d: -f2)\\\"\"
fi
done < <(awk -F: '\$2~/^\\$.+\\$/{print \$1}' /etc/shadow)
}"
    local RISK="Unknown"
    local DESC="All users should have a password change date in the past.

Rationale:
If a user's recorded password change date is in the future, then they could bypass any
set password expiration."
    local ATTACK=""
    local REMEDIATION="Investigate any users with a password change date in the future and correct them.
Locking the account, expiring the password, or resetting the password manually may be
appropriate."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
