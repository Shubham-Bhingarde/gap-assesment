#!/usr/bin/env bash
# controls/5.1.2_access_to_ssh_private_host_key_files_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.2"
    local TITLE="Ensure access to SSH private host key files is configured ((Automated)"
    local EXPECTED="Run the following script to verify SSH private host key files are:
•
•
•
Mode 0600 or more restrictive.
Owned by the root user.
Group owned by the group root.
#!/usr/bin/env bash
{
a_output=() a_output2=() l_pmask=\"0177\"
l_maxperm=\"\$( printf '%o' \$(( 0777 & ~\$l_pmask )) )\"
f_file_chk()
{
while IFS=: read -r l_fmode l_fowner l_fgroup; do
a_out2=()
if [ \$(( \$l_fmode & \$l_pmask )) -gt 0 ]; then
a_out2+=(\"
- mode: \\\"\$l_fmode\\\"\" \
\"
should be mode: \\\"\$l_maxperm\\\" or more restrictive\")
fi
if [ \"\$l_fowner\" != \"root\" ]; then
a_out2+=(\"
- owned by: \\\"\$l_fowner\\\"\" \
\"
should be owned by \\\"root\\\"\")
fi
if [ \"\$l_fgroup\" != \"root\" ]; then
a_out2+=(\"
- group owned by: \\\"\$l_fgroup\\\"\" \
\"
should be group owned by group: \\\"root\\\"\")
fi
if [ \"\${#a_out2[@]}\" -gt \"0\" ]; then
a_output2+=(\" - File: \\\"\$l_file\\\"\" \"\${a_out2[@]}\")
else
a_output+=(\" - File: \\\"\$l_file\\\" Correct:\" \
\"
- mode: \\\"\$l_fmode\\\"\" \
\"
- owner: \\\"\$l_fowner\\\"\" \"
- group owner: \\\"\$l_fgroup\\\"\")
fi
done < <(stat -Lc '%#a:%U:%G' \"\$l_file\")
}
while IFS= read -r -d \$'\0' l_file; do
if ssh-keygen -lf &>/dev/null \"\$l_file\"; then
file \"\$l_file\" | \
grep -Piq -- '\bopenssh\h+([^#\n\r]+\h+)?private\h+key\b' &&
f_file_chk
fi
done < <(find -L /etc/ssh -xdev -type f -print0 2>/dev/null)
if [ \"\${#a_output2[@]}\" -le 0 ]; then
printf '%s\n' \"\" \"- Audit Result:\" \" ** PASS **\" \"\${a_output[@]}\" \"\"
else
printf '%s\n' \"\" \"- Audit Result:\" \" ** FAIL **\" \
\" - Reason(s) for audit failure:\" \"\${a_output2[@]}\"
[ \"\${#a_output[@]}\" -gt 0 ] && \
printf '%s\n' \"\" \"- Correctly set:\" \"\${a_output[@]}\" \"\"
fi
}"
    local RISK="Unknown"
    local DESC="An SSH private key is one of two files used in SSH public key authentication. In this
authentication method, the possession of the private key is proof of identity. Only a
private key that corresponds to a public key will be able to authenticate successfully.
The private keys need to be stored and handled carefully, and no copies of the private
key should be distributed.

Rationale:
If an unauthorized user obtains the private SSH host key file, the host could be
impersonated"
    local ATTACK=""
    local REMEDIATION="Run the following script to set mode, ownership, and group on the private SSH host key
files:
#!/usr/bin/env bash
{
a_output2=() l_pmask=\"0177\"
l_maxperm=\"\$( printf '%o' \$(( 0777 & ~\$l_pmask )) )\"
f_file_access_fix()
{
while IFS=: read -r l_file_mode l_file_owner l_file_group; do
a_out2=()
if [ \$(( \$l_file_mode & \$l_pmask )) -gt 0 ]; then
a_out2+=(\"\" \"
Mode: \\\"\$l_file_mode\\\"\" \
\"
should be mode: \\\"\$l_maxperm\\\" or more restrictive\" \
\"
updating to mode: \\\"\$l_maxperm\\\"\")
chmod u-x,go-rwx \"\$l_file\"
fi
if [ \"\$l_file_owner\" != \"root\" ]; then
a_out2+=(\"\" \"
Owned by: \\\"\$l_file_owner\\\"\" \
\"
should be owned by \\\"root\\\"\" \
\"
Changing ownership to \\\"root\\\"\")
chown root \"\$l_file\"
fi
if [ \"\$l_file_group\" != \"root\" ]; then
a_out2+=(\"\" \"
Owned by group \\\"\$l_file_group\\\"\" \
\"
should be group owned by: \\\"root\\\"\" \
\"
Changing group ownership to group: \\\"root\\\"\")
chgrp root \"\$l_file\"
fi
if [ \"\${#a_out2[@]}\" -gt \"0\" ]; then
a_output2+=(\"\" \" - File: \\\"\$l_file\\\"\" \"\${a_out2[@]}\")
fi
done < <(stat -Lc '%#a:%U:%G' \"\$l_file\")
}
while IFS= read -r -d \$'\0' l_file; do
if ssh-keygen -lf &>/dev/null \"\$l_file\"; then
file \"\$l_file\" | grep -Piq -- \
'\bopenssh\h+([^#\n\r]+\h+)?private\h+key\b' && f_file_access_fix
fi
done < <(find -L /etc/ssh -xdev -type f -print0 2>/dev/null)
if [ \"\${#a_output2[@]}\" -le \"0\" ]; then
printf '%s\n' \"\" \" - No access changes required\" \"\"
else
printf '%s\n' \"\" \" - Remediation results:\" \"\${a_output2[@]}\" \"\"
fi
}"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
