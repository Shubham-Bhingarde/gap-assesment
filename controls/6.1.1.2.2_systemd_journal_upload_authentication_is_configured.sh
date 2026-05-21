#!/usr/bin/env bash
# controls/6.1.1.2.2_systemd_journal_upload_authentication_is_configured.sh

execute_control() {
    local CONTROL_ID="6.1.1.2.2"
    local TITLE="Ensure systemd-journal-upload authentication is configured ((Manual)"
    local EXPECTED="Run the following script to verify systemd-journal-upload authentication is
configured:
#!/usr/bin/env bash
{
l_analyze_cmd=\"\$(readlink -e /bin/systemd-analyze || \
readlink -e /usr/bin/systemd-analyze)\"
l_conf_file=\"systemd/journal-upload.conf\" l_block=\"Upload\"
while IFS= read -r l_file; do
l_file=\"\${l_file//# /}\"
gawk '/\['\"\$l_block\"'\]/{a=1;next}/\[/{a=0}a' \"\$l_file\" \
2>/dev/null | grep -Poi -- \
'^\h*(URL|ServerKeyFile|ServerCertificateFile|TrustedCertificateFile)\h*=\h*\
H+\b'
done < <(\"\$l_analyze_cmd\" cat-config \"\$l_conf_file\" | tac | \
grep -Pio '^\h*#\h*\/[^#\n\r\h]+\.conf\b')
}
Verify the output matches per your environments certificate locations and the URL of
the log server:
Example output:
URL=192.168.50.42
ServerKeyFile=/etc/ssl/private/journal-upload.pem
ServerCertificateFile=/etc/ssl/certs/journal-upload.pem
TrustedCertificateFile=/etc/ssl/ca/trusted.pem"
    local RISK="Unknown"
    local DESC="Journald systemd-journal-upload supports the ability to send log events it gathers to
a remote log host.

Rationale:
Storing log data on a remote host protects log integrity from local attacks. If an attacker
gains root access on the local system, they could tamper with or remove log data that is
stored on the local system.
Note: This recommendation only applies if journald is the chosen method for
client side logging. Do not apply this recommendation if rsyslog is used."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/systemd/journal-upload.conf file or a file in
/etc/systemd/journal-upload.conf.d ending in .conf and ensure the following
lines are set in the [Upload] section per your environment:
[Upload]
URL=192.168.50.42
ServerKeyFile=/etc/ssl/private/journal-upload.pem
ServerCertificateFile=/etc/ssl/certs/journal-upload.pem
TrustedCertificateFile=/etc/ssl/ca/trusted.pem
Example script:
#!/usr/bin/env bash
{
[ ! -d \"/etc/systemd/journal-upload.conf.d\" ] && \
mkdir -p /etc/systemd/journal-upload.conf.d
printf '%s\n' \"\" \"[Upload]\" \"URL=192.168.50.42\" \
\"ServerKeyFile=/etc/ssl/private/journal-upload.pem\" \
\"ServerCertificateFile=/etc/ssl/certs/journal-upload.pem\" \
\"TrustedCertificateFile=/etc/ssl/ca/trusted.pem\" \
>> /etc/systemd/journal-upload.conf.d/60-journal-upload.conf
}
Restart the service:
# systemctl reload-or-restart systemd-journal-upload"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
