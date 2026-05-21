#!/usr/bin/env bash
# controls/6.2.4.10_audit_tools_group_owner_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.4.10"
    local TITLE="Ensure audit tools group owner is configured ((Automated)"
    local EXPECTED="Run the following command to verify the audit tools are owned by the group root
# stat -Lc \"%n %G\" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace
/sbin/auditd /sbin/augenrules | awk '\$2 != \"root\" {print}'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="Audit tools include, but are not limited to, vendor-provided and open source audit tools
needed to successfully view and manipulate audit information system activity and
records. Audit tools include custom queries and report generators.

Rationale:
Protecting audit information includes identifying and protecting the tools used to view
and manipulate log data. Protecting audit tools is necessary to prevent unauthorized
operation on audit information."
    local ATTACK=""
    local REMEDIATION="Run the following command to change group ownership to the group root:
# chgrp root /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace
/sbin/auditd /sbin/augenrules"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
