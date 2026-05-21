#!/usr/bin/env bash
# controls/6.2.4.3_audit_log_files_group_owner_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.4.3"
    local TITLE="Ensure audit log files group owner is configured ((Automated)"
    local EXPECTED="Run the following command to verify log_group parameter is set to either adm or root
in /etc/audit/auditd.conf:
# grep -Piws -- '^\h*log_group\h*=\h*\H+\b' /etc/audit/auditd.conf | grep Pvi -- '(adm)'
Nothing should be returned
Using the path of the directory containing the audit logs, verify audit log files are owned
by the \"root\" or \"adm\" group by running the following script:
#!/usr/bin/env bash
{
if [ -e /etc/audit/auditd.conf ]; then
l_fpath=\"\$(dirname \"\$(awk -F \"=\" '/^\s*log_file/ {print \$2}'
/etc/audit/auditd.conf | xargs)\")\"
find -L \"\$l_fpath\" -maxdepth 1 -not -path \"\$l_fpath\"/lost+found -type f
\( ! -group root -a ! -group adm \) -exec ls -l {} +
fi
}
Nothing should be returned"
    local RISK="Unknown"
    local DESC="Audit log files contain information about the system and system activity.

Rationale:
Access to audit records can reveal system and configuration data to attackers,
potentially compromising its confidentiality."
    local ATTACK=""
    local REMEDIATION="Run the following command to configure the audit log files to be group owned by adm:
# find \$(dirname \$(awk -F\"=\" '/^\s*log_file/ {print \$2}'
/etc/audit/auditd.conf | xargs)) -type f \( ! -group adm -a ! -group root \)
-exec chgrp adm {} +
Run the following command to set the log_group parameter in the audit configuration
file to log_group = adm:
# sed -ri 's/^\s*#?\s*log_group\s*=\s*\S+(\s*#.*)?.*\$/log_group = adm\1/'
/etc/audit/auditd.conf
Run the following command to restart the audit daemon to reload the configuration file:
# systemctl restart auditd"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
