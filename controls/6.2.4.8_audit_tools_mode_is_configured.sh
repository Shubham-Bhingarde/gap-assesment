#!/usr/bin/env bash
# controls/6.2.4.8_audit_tools_mode_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.4.8"
    local TITLE="Ensure audit tools mode is configured ((Automated)"
    local EXPECTED="Run the following script to verify the audit tools are mode 0755 or more restrictive:
#!/usr/bin/env bash
{
l_output=\"\" l_output2=\"\" l_perm_mask=\"0022\"
l_maxperm=\"\$( printf '%o' \$(( 0777 & ~\$l_perm_mask )) )\"
a_audit_tools=(\"/sbin/auditctl\" \"/sbin/aureport\" \"/sbin/ausearch\"
\"/sbin/autrace\" \"/sbin/auditd\" \"/sbin/augenrules\")
for l_audit_tool in \"\${a_audit_tools[@]}\"; do
l_mode=\"\$(stat -Lc '%#a' \"\$l_audit_tool\")\"
if [ \$(( \"\$l_mode\" & \"\$l_perm_mask\" )) -gt 0 ]; then
l_output2=\"\$l_output2\n - Audit tool \\\"\$l_audit_tool\\\" is mode:
\\\"\$l_mode\\\" and should be mode: \\\"\$l_maxperm\\\" or more restrictive\"
else
l_output=\"\$l_output\n - Audit tool \\\"\$l_audit_tool\\\" is correctly
configured to mode: \\\"\$l_mode\\\"\"
fi
done
if [ -z \"\$l_output2\" ]; then
echo -e \"\n- Audit Result:\n ** PASS **\n - * Correctly configured *
:\$l_output\"
else
echo -e \"\n- Audit Result:\n ** FAIL **\n - * Reasons for audit
failure * :\$l_output2\n\"
[ -n \"\$l_output\" ] && echo -e \"\n - * Correctly configured *
:\n\$l_output\n\"
fi
unset a_audit_tools
}"
    local RISK="Unknown"
    local DESC="Audit tools include, but are not limited to, vendor-provided and open source audit tools
needed to successfully view and manipulate audit information system activity and
records. Audit tools include custom queries and report generators.

Rationale:
Protecting audit information includes identifying and protecting the tools used to view
and manipulate log data. Protecting audit tools is necessary to prevent unauthorized
operation on audit information."
    local ATTACK=""
    local REMEDIATION="Run the following command to remove more permissive mode from the audit tools:
# chmod go-w /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace
/sbin/auditd /sbin/augenrules"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
