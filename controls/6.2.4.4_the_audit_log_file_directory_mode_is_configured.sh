#!/usr/bin/env bash
# controls/6.2.4.4_the_audit_log_file_directory_mode_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.4.4"
    local TITLE="Ensure the audit log file directory mode is configured ((Automated)"
    local EXPECTED="Run the following script to verify the audit log directory is mode 0750 or more restrictive:
#!/usr/bin/env bash
{
l_perm_mask=\"0027\"
if [ -e \"/etc/audit/auditd.conf\" ]; then
l_audit_log_directory=\"\$(dirname \"\$(awk -F= '/^\s*log_file\s*/{print
\$2}' /etc/audit/auditd.conf | xargs)\")\"
if [ -d \"\$l_audit_log_directory\" ]; then
l_maxperm=\"\$(printf '%o' \$(( 0777 & ~\$l_perm_mask )) )\"
l_directory_mode=\"\$(stat -Lc '%#a' \"\$l_audit_log_directory\")\"
if [ \$(( \$l_directory_mode & \$l_perm_mask )) -gt 0 ]; then
echo -e \"\n- Audit Result:\n ** FAIL **\n - Directory:
\\\"\$l_audit_log_directory\\\" is mode: \\\"\$l_directory_mode\\\"\n
(should be
mode: \\\"\$l_maxperm\\\" or more restrictive)\n\"
else
echo -e \"\n- Audit Result:\n ** PASS **\n - Directory:
\\\"\$l_audit_log_directory\\\" is mode: \\\"\$l_directory_mode\\\"\n
(should be
mode: \\\"\$l_maxperm\\\" or more restrictive)\n\"
fi
else
echo -e \"\n- Audit Result:\n ** FAIL **\n - Log file directory not
set in \\\"/etc/audit/auditd.conf\\\" please set log file directory\"
fi
else
echo -e \"\n- Audit Result:\n ** FAIL **\n - File:
\\\"/etc/audit/auditd.conf\\\" not found\n - ** Verify auditd is installed **\"
fi
}"
    local RISK="Unknown"
    local DESC="The audit log directory contains audit log files.

Rationale:
Audit information includes all information including: audit records, audit settings and
audit reports. This information is needed to successfully audit system activity. This
information must be protected from unauthorized modification or deletion. If this
information were to be compromised, forensic analysis and discovery of the true source
of potentially malicious system activity is impossible to achieve."
    local ATTACK=""
    local REMEDIATION="Run the following command to configure the audit log directory to have a mode of
\"0750\" or less permissive:
# chmod g-w,o-rwx \"\$(dirname \"\$(awk -F= '/^\s*log_file\s*/{print \$2}'
/etc/audit/auditd.conf | xargs)\")\""

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
