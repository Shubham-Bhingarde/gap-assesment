#!/usr/bin/env bash
# controls/5.4.2.8_accounts_without_a_valid_login_shell_are_locked.sh

execute_control() {
    local CONTROL_ID="5.4.2.8"
    local TITLE="Ensure accounts without a valid login shell are locked ((Automated)"
    local EXPECTED="Run the following script to verify all non-root accounts without a valid login shell are
locked.
#!/usr/bin/env bash
{
l_valid_shells=\"^(\$(awk -F\/ '\$NF != \"nologin\" {print}' /etc/shells | sed
-rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))\$\"
while IFS= read -r l_user; do
passwd -S \"\$l_user\" | awk '\$2 !~ /^L/ {print \"Account: \\"\" \$1 \"\\" does
not have a valid login shell and is not locked\"}'
done < <(awk -v pat=\"\$l_valid_shells\" -F: '(\$1 != \"root\" && \$(NF) !~ pat)
{print \$1}' /etc/passwd)
}
Nothing should be returned"
    local RISK="Unknown"
    local DESC="There are a number of accounts provided with most distributions that are used to
manage applications and are not intended to provide an interactive shell. Furthermore,
a user may add special accounts that are not intended to provide an interactive shell.

Rationale:
It is important to make sure that accounts that are not being used by regular users are
prevented from being used to provide an interactive shell. By default, most distributions
set the password field for these accounts to an invalid string, but it is also recommended
that the shell field in the password file be set to the nologin shell. This prevents the
account from potentially being used to run any commands."
    local ATTACK=""
    local REMEDIATION="Run the following command to lock any non-root accounts without a valid login shell
returned by the audit:
# usermod -L <user>
Example script:
#!/usr/bin/env bash
{
l_valid_shells=\"^(\$(awk -F\/ '\$NF != \"nologin\" {print}' /etc/shells | sed
-rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))\$\"
while IFS= read -r l_user; do
passwd -S \"\$l_user\" | awk '\$2 !~ /^L/ {system (\"usermod -L \" \$1)}'
done < <(awk -v pat=\"\$l_valid_shells\" -F: '(\$1 != \"root\" && \$(NF) !~ pat)
{print \$1}' /etc/passwd)
}"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
