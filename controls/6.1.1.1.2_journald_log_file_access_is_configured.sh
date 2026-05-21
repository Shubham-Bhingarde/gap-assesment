#!/usr/bin/env bash
# controls/6.1.1.1.2_journald_log_file_access_is_configured.sh

execute_control() {
    local CONTROL_ID="6.1.1.1.2"
    local TITLE="Ensure journald log file access is configured ((Manual)"
    local EXPECTED="First determine if there is an override file /etc/tmpfiles.d/systemd.conf. If so, this
file will override all default settings as defined in /usr/lib/tmpfiles.d/systemd.conf
and should be inspected.
If no override file exists, inspect the default /usr/lib/tmpfiles.d/systemd.conf
against the site specific requirements.
Ensure that file permissions are mode 0640 or more restrictive.
Run the following script to verify if an override file exists or not and if the files
permissions are mode 0640 or more restrictive:
#!/usr/bin/env bash
{
config_files=(/etc/tmpfiles.d/systemd.conf /usr/lib/tmpfiles.d/systemd.conf)
warn=()
for file in \"\${config_files[@]}\"; do
[ -f \"\$file\" ] || continue
while read -r type path perm _; do
if [[ \"\$type\" == \"f\" && \"\$perm\" =~ ^0?[0-7]{3,4}\$ ]]; then
perm=\"\${perm#0}\"
if [ -f \"\$path\" ]; then
actual=\$(stat -c \"%a\" \"\$path\" 2>/dev/null)
if [[ -n \"\$actual\" && \"\$actual\" -gt 640 ]]; then
warn+=(\"File: \$path | Perm: \$actual (expected max: 640) | Defined
in: \$file\")
fi
fi
fi
done < \"\$file\"
done
if [ \"\${#warn[@]}\" -eq 0 ]; then
echo \"No files with permissions more permissive than 0640.\"
else
echo -e \" *** REVIEW ***\"
printf \"%s\n\" \"\${warn[@]}\"
fi
}"
    local RISK="Unknown"
    local DESC="Journald will create logfiles that do not already exist on the system. This setting controls
what permissions will be applied to these newly created files.

Rationale:
It is important to ensure that log files have the correct permissions to ensure that
sensitive data is archived and protected."
    local ATTACK=""
    local REMEDIATION="If the default configuration is not appropriate for the site specific requirements, copy
/usr/lib/tmpfiles.d/systemd.conf to /etc/tmpfiles.d/systemd.conf and
modify as required. Requirements is either 0640 or site policy if that is less restrictive."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
