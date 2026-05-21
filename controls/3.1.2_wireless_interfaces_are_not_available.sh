#!/usr/bin/env bash
# controls/3.1.2_wireless_interfaces_are_not_available.sh

execute_control() {
    local CONTROL_ID="3.1.2"
    local TITLE="Ensure wireless interfaces are not available ((Automated)"
    local EXPECTED="Run the following script to verify no wireless interfaces are active on the system:
#!/usr/bin/env bash
{
l_output=\"\" l_output2=\"\"
module_chk()
{
# Check how module will be loaded
l_loadable=\"\$(modprobe -n -v \"\$l_mname\")\"
if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< \"\$l_loadable\";
then
l_output=\"\$l_output\n - module: \\"\$l_mname\\" is not loadable:
\\"\$l_loadable\\"\"
else
l_output2=\"\$l_output2\n - module: \\"\$l_mname\\" is loadable:
\\"\$l_loadable\\"\"
fi
# Check is the module currently loaded
if ! lsmod | grep \"\$l_mname\" > /dev/null 2>&1; then
l_output=\"\$l_output\n - module: \\"\$l_mname\\" is not loaded\"
else
l_output2=\"\$l_output2\n - module: \\"\$l_mname\\" is loaded\"
fi
# Check if the module is deny listed
if modprobe --showconfig | grep -Pq -- \"^\h*blacklist\h+\$l_mname\b\";
then
l_output=\"\$l_output\n - module: \\"\$l_mname\\" is deny listed in:
\\"\$(grep -Pl -- \"^\h*blacklist\h+\$l_mname\b\" /etc/modprobe.d/*)\\"\"
else
l_output2=\"\$l_output2\n - module: \\"\$l_mname\\" is not deny listed\"
fi
}
if [ -n \"\$(find /sys/class/net/*/ -type d -name wireless)\" ]; then
l_dname=\$(for driverdir in \$(find /sys/class/net/*/ -type d -name
wireless | xargs -0 dirname); do basename \"\$(readlink -f
\"\$driverdir\"/device/driver/module)\";done | sort -u)
for l_mname in \$l_dname; do
module_chk
done
fi
# Report results. If no failures output in l_output2, we pass
if [ -z \"\$l_output2\" ]; then
echo -e \"\n- Audit Result:\n ** PASS **\"
if [ -z \"\$l_output\" ]; then
echo -e \"\n - System has no wireless NICs installed\"
else
echo -e \"\n\$l_output\n\"
fi
else
echo -e \"\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit
failure:\n\$l_output2\n\"
[ -n \"\$l_output\" ] && echo -e \"\n- Correctly set:\n\$l_output\n\"
fi
}"
    local RISK="Unknown"
    local DESC="Wireless networking is used when wired networks are unavailable.

Rationale:
-IF- wireless is not to be used, wireless devices can be disabled to reduce the potential
attack surface."
    local ATTACK="Many if not all laptop workstations and some desktop workstations will connect via
wireless requiring these interfaces be enabled."
    local REMEDIATION="Run the following command to disable any wireless interfaces:
# find /lib/modules/\`uname -r\`/kernel/drivers/net/wireless -name '*.ko' printf 'install %f /bin/false\nblacklist %f\n\n' | sed 's/\.ko//1' >>
/etc/modprobe.d/blacklist-wireless.conf
Note: the *.conf file in /etc/modprobe.d/ in the above command can renamed as
needed."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
