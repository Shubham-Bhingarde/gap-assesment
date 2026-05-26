#!/usr/bin/env bash
# controls/6.2.4.5_audit_configuration_files_mode_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.4.5"
    local TITLE="Ensure audit configuration files mode is configured ((Automated)"
    local EXPECTED="Run the following script to verify that the audit configuration files are mode 0640 or more
restrictive:
#!/usr/bin/env bash
{
l_output=\"\" l_output2=\"\" l_perm_mask=\"0137\"
l_maxperm=\"\$( printf '%o' \$(( 0777 & ~\$l_perm_mask )) )\"
while IFS= read -r -d \$'\0' l_fname; do
l_mode=\$(stat -Lc '%#a' \"\$l_fname\")
if [ \$(( \"\$l_mode\" & \"\$l_perm_mask\" )) -gt 0 ]; then
l_output2=\"\$l_output2\n - file: \\\"\$l_fname\\\" is mode: \\\"\$l_mode\\\"
(should be mode: \\\"\$l_maxperm\\\" or more restrictive)\"
fi
done < <(find /etc/audit/ -type f \( -name \"*.conf\" -o -name '*.rules' \)
-print0)
if [ -z \"\$l_output2\" ]; then
echo -e \"\n- Audit Result:\n ** PASS **\n - All audit configuration
files are mode: \\\"\$l_maxperm\\\" or more restrictive\"
else
echo -e \"\n- Audit Result:\n ** FAIL **\n\$l_output2\"
fi
}"
    local RISK="Unknown"
    local DESC="Audit configuration files control auditd and what events are audited.

Rationale:
Access to the audit configuration files could allow unauthorized personnel to prevent the
auditing of critical events.
Misconfigured audit configuration files may prevent the auditing of critical events or
impact the system's performance by overwhelming the audit log. Misconfiguration of the
audit configuration files may also make it more difficult to establish and investigate
events relating to an incident."
    local ATTACK=""
    local REMEDIATION="Run the following command to remove more permissive mode than 0640 from the audit
configuration files:
# find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec
chmod u-x,g-wx,o-rwx {} +"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
