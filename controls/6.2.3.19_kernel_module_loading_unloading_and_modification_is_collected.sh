#!/usr/bin/env bash
# controls/6.2.3.19_kernel_module_loading_unloading_and_modification_is_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.19"
    local TITLE="Ensure kernel module loading unloading and modification is collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following script to check the on disk rules:
#!/usr/bin/env bash
{
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
&&/ -S/ \
&&(/init_module/ \
||/finit_module/ \
||/delete_module/ \
||/query_module/) \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && awk \"/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/kmod/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" /etc/audit/rules.d/*.rules \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output matches:
-a always,exit -F arch=b64 -S
init_module,finit_module,delete_module,query_module -F auid>=1000 -F
auid!=unset -k kernel_modules
-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=unset k kernel_modules
Running configuration
Run the following script to check loaded rules:
#!/usr/bin/env bash
{
auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
&&/ -S/ \
&&(/init_module/ \
||/finit_module/ \
||/delete_module/ \
||/query_module/) \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && auditctl -l | awk \"/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/kmod/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output includes:
-a always,exit -F arch=b64 -S
init_module,delete_module,query_module,finit_module -F auid>=1000 -F auid!=-1
-F key=kernel_modules
-a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F
auid!=-1 -F key=kernel_modules
Symlink audit
Run the following script to audit if the symlinks kmod accepts are indeed pointing at it:
#!/usr/bin/env bash
{
a_files=(\"/usr/sbin/lsmod\" \"/usr/sbin/rmmod\" \"/usr/sbin/insmod\"
\"/usr/sbin/modinfo\" \"/usr/sbin/modprobe\" \"/usr/sbin/depmod\")
for l_file in \"\${a_files[@]}\"; do
if [ \"\$(readlink -f \"\$l_file\")\" = \"\$(readlink -f /bin/kmod)\" ]; then
printf \"OK: \\"\$l_file\\"\n\"
else
printf \"Issue with symlink for file: \\"\$l_file\\"\n\"
fi
done
}
Verify the output states OK. If there is a symlink pointing to a different location it should
be investigated"
    local RISK="Unknown"
    local DESC="Monitor the loading and unloading of kernel modules. All the loading / listing /
dependency checking of modules is done by kmod via symbolic links.
The following system calls control loading and unloading of modules:
•
•
•
•
init_module - load a module
finit_module - load a module (used when the overhead of using
cryptographically signed modules to determine the authenticity of a module can
be avoided)
delete_module - delete a module
query_module - query the kernel for various bits pertaining to modules
Any execution of the loading and unloading module programs and system calls will
trigger an audit record with an identifier of modules.

Rationale:
Monitoring the use of all the various ways to manipulate kernel modules could provide
system administrators with evidence that an unauthorized change was made to a kernel
module, possibly compromising the security of the system."
    local ATTACK=""
    local REMEDIATION="Create audit rules
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor kernel module modification.
Example:
#!/usr/bin/env bash
{
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && printf \"
-a always,exit -F arch=b64 -S
init_module,finit_module,delete_module,query_module -F auid>=\${UID_MIN} -F
auid!=unset -k kernel_modules
-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=\${UID_MIN} -F
auid!=unset -k kernel_modules
\" >> /etc/audit/rules.d/50-kernel_modules.rules || printf \"ERROR: Variable
'UID_MIN' is unset.\n\"
}
Load audit rules
Merge and load the rules into active configuration:
# augenrules --load
Check if reboot is required.
# if [[ \$(auditctl -s | grep \"enabled\") =~ \"2\" ]]; then printf \"Reboot
required to load rules\n\"; fi"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
