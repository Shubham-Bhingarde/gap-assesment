#!/usr/bin/env bash
# controls/6.3.3_cryptographic_mechanisms_are_used_to_protect_the_integrity_of_audit_tools.sh

execute_control() {
    local CONTROL_ID="6.3.3"
    local TITLE="Ensure cryptographic mechanisms are used to protect the integrity of audit tools ((Automated)"
    local EXPECTED="Verify that Advanced Intrusion Detection Environment (AIDE) is properly configured .
Run the following script to verify:
•
•
AIDE is configured to use cryptographic mechanisms to protect the integrity of
audit tools:
The following audit tool files include the options \"p, i, n, u, g, s, b, acl, xattrs and
sha512\"
o auditctl
o auditd
o ausearch
o aureport
o autrace
o augenrules
#!/usr/bin/env bash
{
a_output=();a_output2=();a_output3=();a_parlist=()
l_systemd_analyze=\"\$(readlink -e /bin/systemd-analyze || readlink -e
/usr/bin/systemd-analyze)\"
a_audit_files=(\"auditctl\" \"auditd\" \"ausearch\" \"aureport\" \"autrace\"
\"augenrules\")
f_parameter_chk()
{
for l_tool_file in \"\${a_parlist[@]}\"; do
if grep -Pq -- '\b'\"\$l_tool_file\"'\b' <<< \"\${!A_out[*]}\"; then
for l_string in \"\${!A_out[@]}\"; do
l_check=\"\$(grep -Po -'^\h*(\/usr)?\/sbin\/'\"\$l_tool_file\"'\b' <<< \"\$l_string\")\"
if [ -n \"\$l_check\" ]; then
l_fname=\"\$(printf '%s' \"\${A_out[\$l_string]}\")\"
[ \"\$l_check\" != \"\$(readlink -f \"\$l_check\")\" ] && \
a_output3+=(\" - \\"\$l_check\\" should be updated to:
\\"\$(readlink -e \"\$l_check\")\\"\" \"
in: \\"\$l_fname\\"\")
a_missing=()
for l_var in \"\${a_items[@]}\"; do
if ! grep -Pq -- \"\b\$l_var\b\" <<< \"\$l_string\"; then
a_missing+=(\"\\"\$l_var\\"\")
fi
done
if [ \"\${#a_missing[@]}\" -gt 0 ]; then
a_output2+=(\" - Option(s): ( \${a_missing[*]} ) are
missing from: \\"\$l_tool_file\\" in: \\"\$l_fname\\"\")
else
a_output+=(\" - Audit tool file \\"\$l_tool_file\\" exists
as:\" \"
\\"\$l_string\\"\" \"
in the configuration file: \\"\$l_fname\\"\")
fi
fi
done
else
a_output2+=(\" - Audit tool file \\"\$l_tool_file\\" doesn't exist in
an AIDE configuration file\")
fi
done
}
f_aide_conf()
{
l_config_file=\"\$(readlink -e /etc/aide/aide.conf || readlink -e
/etc/aide.conf)\"
if [ -f \"\$l_config_file\" ]; then
a_items=(\"p\" \"i\" \"n\" \"u\" \"g\" \"s\" \"b\" \"acl\" \"xattrs\" \"sha512\")
declare -A A_out
while IFS= read -r l_out; do
if grep -Pq -- '^\h*\#\h*\/[^#\n\r]+\.conf\b' <<< \"\$l_out\"; then
l_file=\"\${l_out//# /}\"
else
for i in \"\${a_parlist[@]}\"; do
grep -Pq -- '^\h*(\/usr)?\/sbin\/'\"\$i\"'\b' <<< \"\$l_out\" &&
A_out+=([\"\$l_out\"]=\"\$l_file\")
done
fi
done < <(\"\$l_systemd_analyze\" cat-config \"\$l_config_file\" | grep Pio '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
if [ \"\${#A_out[@]}\" -gt 0 ]; then
f_parameter_chk
else
a_output2+=(\" - No audit tool files are configured in an AIDE
configuration file\")
fi
else
a_output2+=(\" - AIDE configuration file not found.\" \"
Please
verify AIDE is installed on the system\")
fi
}
for l_audit_file in \"\${a_audit_files[@]}\"; do
if [ -f \"\$(readlink -f \"/sbin/\$l_audit_file\")\" ]; then
a_parlist+=(\"\$l_audit_file\")
else
a_output+=(\" - Audit tool file \\"\$(readlink -f
\"/sbin/\$l_audit_file\")\\" doesn't exist\")
fi
done
[ \"\${#a_parlist[@]}\" -gt 0 ] && f_aide_conf
if [ \"\${#a_output2[@]}\" -le 0 ]; then
printf '%s\n' \"\" \"- Audit Result:\" \" ** PASS **\" \"\${a_output[@]}\"
[ \"\${#a_output3[@]}\" -gt 0 ] && printf '%s\n' \"\" \" ** WARNING **\"
\"\${a_output3[@]}\"
else
printf '%s\n' \"\" \"- Audit Result:\" \" ** FAIL **\" \" * Reasons for
audit failure *\" \"\${a_output2[@]}\" \"\"
[ \"\${#a_output3[@]}\" -gt 0 ] && printf '%s\n' \"\" \" ** WARNING **\"
\"\${a_output3[@]}\"
[ \"\${#a_output[@]}\" -gt 0 ] && printf '%s\n' \"- Correctly set:\"
\"\${a_output[@]}\"
fi
}
Note: The script is written to read the \"winning\" configuration setting, to include any
configuration settings in files included as part of the @@x_include setting."
    local RISK="Unknown"
    local DESC="Audit tools include, but are not limited to, vendor-provided and open source audit tools
needed to successfully view and manipulate audit information system activity and
records. Audit tools include custom queries and report generators.

Rationale:
Protecting the integrity of the tools used for auditing purposes is a critical step toward
ensuring the integrity of audit information. Audit information includes all information
(e.g., audit records, audit settings, and audit reports) needed to successfully audit
information system activity.
Attackers may replace the audit tools or inject code into the existing tools with the
purpose of providing the capability to hide or erase system activity from the audit logs.
Audit tools should be cryptographically signed in order to provide the capability to
identify when the audit tools have been modified, manipulated, or replaced. An example
is a checksum hash of the file or files."
    local ATTACK=""
    local REMEDIATION="Run the following command to determine the absolute path to the non-symlinked
version on the audit tools:
# readlink -e /sbin
The output will be either /usr/sbin - OR - /sbin. Ensure the correct path is used.
Edit /etc/aide/aide.conf and add or update the following selection lines replacing
<PATH> with the correct path returned in the command above:
# Audit Tools
<PATH>/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512
<PATH>/auditd p+i+n+u+g+s+b+acl+xattrs+sha512
<PATH>/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512
<PATH>/aureport p+i+n+u+g+s+b+acl+xattrs+sha512
<PATH>/autrace p+i+n+u+g+s+b+acl+xattrs+sha512
<PATH>/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512
Example
# printf '%s\n' \"\" \"# Audit Tools\" \"\$(readlink -e /sbin/auditctl)
p+i+n+u+g+s+b+acl+xattrs+sha512\" \"\$(readlink -e /sbin/auditd)
p+i+n+u+g+s+b+acl+xattrs+sha512\" \"\$(readlink -e /sbin/ausearch)
p+i+n+u+g+s+b+acl+xattrs+sha512\" \"\$(readlink -e /sbin/aureport)
p+i+n+u+g+s+b+acl+xattrs+sha512\" \"\$(readlink -e /sbin/autrace)
p+i+n+u+g+s+b+acl+xattrs+sha512\" \"\$(readlink -e /sbin/augenrules)
p+i+n+u+g+s+b+acl+xattrs+sha512\" >> \"\$(readlink -e /etc/aide/aide.conf ||
readlink -e /etc/aide.conf)\"
Note: - IF - /etc/aide/aide.conf includes a @@x_include statement:
Example:
@@x_include /etc/aide/aide.conf.d ^[a-zA-Z0-9_-]+\$
•
•
@@x_include FILE
@@x_include DIRECTORY REGEX
o @x_include is identical to @@include, except that if a config file is
executable it is run and the output is used as config.
o If the executable file exits with status greater than zero or writes to stderr
aide stops with an error.
o For security reasons DIRECTORY and each executable config file must
be owned by the current user and must not be group or world-writable."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
