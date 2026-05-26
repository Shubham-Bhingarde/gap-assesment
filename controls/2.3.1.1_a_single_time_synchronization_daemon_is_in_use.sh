#!/usr/bin/env bash
# controls/2.3.1.1_a_single_time_synchronization_daemon_is_in_use.sh

execute_control() {
    local CONTROL_ID="2.3.1.1"
    local TITLE="Ensure a single time synchronization daemon is in use ((Automated)"
    local EXPECTED="On physical systems, and virtual systems where host based time synchronization is not
available.
One of the two time synchronization daemons should be available; chrony or systemdtimesyncd
Run the following script to verify that a single time synchronization daemon is available
on the system:
#!/usr/bin/env bash
{
l_output=\"\" l_output2=\"\"
service_not_enabled_chk()
{
l_out2=\"\"
if systemctl is-enabled \"\$l_service_name\" 2>/dev/null | grep -q 'enabled';
then
l_out2=\"\$l_out2\n - Daemon: \\\"\$l_service_name\\\" is enabled on the system\"
fi
if systemctl is-active \"\$l_service_name\" 2>/dev/null | grep -q '^active'; then
l_out2=\"\$l_out2\n - Daemon: \\\"\$l_service_name\\\" is active on the system\"
fi
}
l_service_name=\"systemd-timesyncd.service\" # Check systemd-timesyncd daemon
service_not_enabled_chk
if [ -n \"\$l_out2\" ]; then
l_timesyncd=\"y\"
l_out_tsd=\"\$l_out2\"
else
l_timesyncd=\"n\"
l_out_tsd=\"\n - Daemon: \\\"\$l_service_name\\\" is not enabled and not active on
the system\"
fi
l_service_name=\"chrony.service\" # Check chrony
service_not_enabled_chk
if [ -n \"\$l_out2\" ]; then
l_chrony=\"y\"
l_out_chrony=\"\$l_out2\"
else
l_chrony=\"n\"
l_out_chrony=\"\n - Daemon: \\\"\$l_service_name\\\" is not enabled and not active
on the system\"
fi
l_status=\"\$l_timesyncd\$l_chrony\"
case \"\$l_status\" in
yy)
l_output2=\" - More than one time sync daemon is in use on the
system\$l_out_tsd\$l_out_chrony\"
;;
nn)
l_output2=\" - No time sync daemon is in use on the
system\$l_out_tsd\$l_out_chrony\"
;;
yn|ny)
l_output=\" - Only one time sync daemon is in use on the
system\$l_out_tsd\$l_out_chrony\"
;;
*)
l_output2=\" - Unable to determine time sync daemon(s) status\"
;;
esac
if [ -z \"\$l_output2\" ]; then
echo -e \"\n- Audit Result:\n
else
echo -e \"\n- Audit Result:\n
:\n\$l_output2\n\"
fi
}
** PASS **\n\$l_output\n\"
** FAIL **\n - * Reasons for audit failure *
Note: Follow the guidance in the subsection for the time synchronization daemon
available on the system and skip the other time synchronization daemon subsection."
    local RISK="Unknown"
    local DESC="System time should be synchronized between all systems in an environment. This is
typically done by establishing an authoritative time server or set of servers and having
all systems synchronize their clocks to them.
Note:
•
•
On virtual systems where host based time synchronization is available
consult your virtualization software documentation and verify that host
based synchronization is in use and follows local site policy. In this
scenario, this section should be skipped
Only one time synchronization method should be in use on the system.
Configuring multiple time synchronization methods could lead to unexpected or
unreliable results

Rationale:
Time synchronization is important to support time sensitive security mechanisms and
ensures log files have consistent time records across the enterprise, which aids in
forensic investigations."
    local ATTACK=""
    local REMEDIATION="On physical systems, and virtual systems where host based time synchronization is not
available.
Select one of the two time synchronization daemons; chrony (1) or systemdtimesyncd (2) and following the remediation procedure for the selected daemon.
Note: enabling more than one synchronization daemon could lead to unexpected or
unreliable results:
1. chrony
Run the following command to install chrony:
# apt install chrony
Run the following commands to stop and mask the systemd-timesyncd daemon:
# systemctl stop systemd-timesyncd.service
# systemctl mask systemd-timesyncd.service
Note:
•
•
Subsection: Configure chrony should be followed
Subsection: Configure systemd-timesyncd should be skipped
2. systemd-timesyncd
Run the following command to remove the chrony package:
# apt purge chrony
# apt autoremove chrony
Note:
•
•
Subsection: Configure systemd-timesyncd should be followed
Subsection: Configure chrony should be skipped"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
