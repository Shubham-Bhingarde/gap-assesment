#!/usr/bin/env bash
# controls/5.4.2.5_root_path_integrity.sh

execute_control() {
    local CONTROL_ID="5.4.2.5"
    local TITLE="Ensure root path integrity ((Automated)"
    local EXPECTED="Run the following script to verify root's path does not include:
• Locations that are not directories
• An empty directory (::)
• A trailing (:)
• Current working directory (.)
• Non root owned directories
• Directories that less restrictive than mode 0755
#!/usr/bin/env bash
{
a_output2=() l_pmask=\"0022\"
l_maxperm=\"\$( printf '%o' \$(( 0777 & ~\$l_pmask )) )\"
l_root_path=\"\$(sudo su - root -c env | awk -F= '\$1==\"PATH\"{print \$2}')\"
IFS=\":\" read -ra a_path_loc <<< \"\$l_root_path\"
grep -q -- \"::\" <<< \"\$l_root_path\" && \
a_output2+=(\" - root's path contains a empty directory (::)\")
grep -Pq -- \":\h*\$\" <<< \"\$l_root_path\" && \
a_output2+=(\" - root's path contains a trailing (:)\")
grep -Pq -- '(^\h*|:)\.(:|\h*\$)' <<< \"\$l_root_path\" && \
a_output2+=(\" - root's path contains current working directory (.)\")
for l_path in \"\${a_path_loc[@]}\"; do
if [ -d \"\$l_path\" ]; then
while IFS=: read -r l_fmode l_fown; do
[ \"\$l_fown\" != \"root\" ] && \
a_output2+=(\" - Directory: \\"\$l_path\\" is owned by: \\"\$l_fown\\"\"
\
\"
should be owned by \\"root\\"\")
[ \$(( \$l_fmode & \$l_pmask )) -gt 0 ] && \
a_output2+=(\" - Directory: \\"\$l_path\\" is mode: \\"\$l_fmode\\"\" \
\"
and should be mode: \\"\$l_maxperm\\" or more restrictive\")
done <<< \"\$(stat -Lc '%#a:%U' \"\$l_path\")\"
else
a_output2+=(\" - \\"\$l_path\\" is not a directory\")
fi
done
if [ \"\${#a_output2[@]}\" -le 0 ]; then
printf '%s\n' \"\" \"- Audit Result:\" \" ** PASS **\" \
\" - Root's path is correctly configured\"
else
printf '%s\n' \"\" \"- Audit Result:\" \" ** FAIL **\" \
\"- * Reasons for audit failure * :\" \"\${a_output2[@]}\"
fi
}"
    local RISK="Unknown"
    local DESC="The root user can execute any command on the system and could be fooled into
executing programs unintentionally if the PATH is not set correctly.

Rationale:
Including the current working directory (.) or other writable directory in root's
executable path makes it likely that an attacker can gain superuser access by forcing an
administrator operating as root to execute a Trojan horse program."
    local ATTACK=""
    local REMEDIATION="Correct or justify any:
•
•
•
•
•
•
Locations that are not directories
Empty directories (::)
Trailing (:)
Current working directory (.)
Non root owned directories
Directories that less restrictive than mode 0755"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
