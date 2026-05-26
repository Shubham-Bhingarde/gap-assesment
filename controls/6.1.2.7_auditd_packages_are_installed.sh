#!/usr/bin/env bash
# controls/6.1.2.7_auditd_packages_are_installed.sh

execute_control() {
    local CONTROL_ID="6.1.2.7"
    local TITLE="    Ensure auditd packages are installed ((Automated)"
    local EXPECTED="Review the /etc/rsyslog.conf and /etc/rsyslog.d/*.conf files and verify that the
system is not configured to accept incoming logs.
advanced format
# grep -Psi -- '^\h*module\(load=\\\"?imtcp\\\"?\)' /etc/rsyslog.conf
/etc/rsyslog.d/*.conf
# grep -Psi -- '^\h*input\(type=\\\"?imtcp\\\"?\b' /etc/rsyslog.conf
/etc/rsyslog.d/*.conf
Nothing should be returned
obsolete legacy format
# grep -Psi -- '^\h*\\$ModLoad\h+imtcp\b' /etc/rsyslog.conf
/etc/rsyslog.d/*.conf
# grep -Psi -- '^\h*\\$InputTCPServerRun\b' /etc/rsyslog.conf
/etc/rsyslog.d/*.conf
Nothing should be returned"
    local RISK="Unknown"
    local DESC="rsyslog supports the ability to receive messages from remote hosts, thus acting as a
log server. Clients should not receive data from other hosts.

Rationale:
If a client is configured to also receive data, thus turning it into a server, the client
system is acting outside its operational boundary."
    local ATTACK=""
    local REMEDIATION="Should there be any active log server configuration found in the auditing section, modify
those files and remove the specific lines highlighted by the audit. Verify none of the
following entries are present in any of /etc/rsyslog.conf or
/etc/rsyslog.d/*.conf.
advanced format
module(load=\"imtcp\")
input(type=\"imtcp\" port=\"514\")
deprecated legacy format
\$ModLoad imtcp
\$InputTCPServerRun
Restart the service:
# systemctl restart rsyslog"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
