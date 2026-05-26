#!/usr/bin/env bash
# controls/5.4.2.7_system_accounts_do_not_have_a_valid_login_shell.sh

execute_control() {
    local CONTROL_ID="5.4.2.7"
    local TITLE="Ensure system accounts do not have a valid login shell ((Automated)"
    local EXPECTED="Run the following command to verify system accounts, except for root, halt, sync,
shutdown or nfsnobody, do not have a valid login shell:
#!/usr/bin/env bash
{
l_valid_shells=\"^(\$(awk -F\/ '\$NF != \"nologin\" {print}' /etc/shells | sed
-rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))\$\"
awk -v pat=\"\$l_valid_shells\" -F:
'(\$1!~/^(root|halt|sync|shutdown|nfsnobody)\$/ && (\$3<'\"\$(awk
'/^\s*UID_MIN/{print \$2}' /etc/login.defs)\"' || \$3 == 65534) && \$(NF) ~ pat)
{print \"Service account: \\\"\" \$1 \"\\\" has a valid shell: \" \$7}' /etc/passwd
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
    local REMEDIATION="Run the following command to set the shell for any service accounts returned by the
audit to nologin:
# usermod -s \$(command -v nologin) <user>
Example script:
#!/usr/bin/env bash
{
l_valid_shells=\"^(\$( awk -F\/ '\$NF != \"nologin\" {print}' /etc/shells | sed
-rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))\$\"
awk -v pat=\"\$l_valid_shells\" -F:
'(\$1!~/^(root|halt|sync|shutdown|nfsnobody)\$/ && (\$3<'\"\$(awk
'/^\s*UID_MIN/{print \$2}' /etc/login.defs)\"' || \$3 == 65534) && \$(NF) ~ pat)
{system (\"usermod -s '\"\$(command -v nologin)\"' \" \$1)}' /etc/passwd
}"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
