#!/usr/bin/env bash
# controls/5.4.3.3_default_user_umask_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.3.3"
    local TITLE="Ensure default user umask is configured ((Automated)"
    local EXPECTED="Run the following commands to verify the systemwide umask is 0027
(u=rwx,g=rx,o=) or more restrictive:
1. Run the following command to verify umask is set to 027 or more restrictive in a
file ending in .sh in /etc/profile.d/
# grep -Psi -- '^\h*umask\b' /etc/profile.d/*.sh
Example output:
umask 027
2. Run the following command to verify UMASK is 027 or more restrictive in
/etc/login.defs:
# grep -Psi -- '^\h*UMASK\b' /etc/login.defs
Example output:
UMASK
027"
    local RISK="Unknown"
    local DESC="The user file-creation mode mask (umask) is used to determine the file permission for
newly created directories and files. In Linux, the default permissions for any newly
created directory is 0777 (rwxrwxrwx), and for any newly created file it is 0666 (rw-rwrw-). The umask modifies the default Linux permissions by restricting (masking) these
permissions. The umask is not simply subtracted, but is processed bitwise. Bits set in
the umask are cleared in the resulting file mode.
umask can be set with either Octal or Symbolic values:
•
•
Octal (Numeric) Value - Represented by either three or four digits. ie umask
0027 or umask 027. If a four digit umask is used, the first digit is ignored. The
remaining three digits effect the resulting permissions for user, group, and
world/other respectively.
Symbolic Value - Represented by a comma separated list for User u, group g,
and world/other o. The permissions listed are not masked by umask. ie a umask
set by umask u=rwx,g=rx,o= is the Symbolic equivalent of the Octal umask
027. This umask would set a newly created directory with file mode drwxr-x--and a newly created file with file mode rw-r-----.
The default umask can be set to use the pam_umask module or in a System Wide
Shell Configuration File. The user creating the directories or files has the
discretion of changing the permissions via the chmod command, or choosing a different
default umask by adding the umask command into a User Shell Configuration
File, ( .bash_profile or .bashrc), in their home directory.
Setting the default umask:
•
pam_umask module:
o will set the umask according to the system default in /etc/login.defs
and user settings, solving the problem of different umask settings with
different shells, display managers, remote sessions etc.
o umask=<mask> value in the /etc/login.defs file is interpreted as Octal
o Setting USERGROUPS_ENAB to yes in /etc/login.defs (default):
▪ will enable setting of the umask group bits to be the same as owner
bits. (examples: 022 -> 002, 077 -> 007) for non-root users, if the
uid is the same as gid, and username is the same as the
<primary group name>
userdel will remove the user's group if it contains no more
members, and useradd will create by default a group with the name
of the user
System Wide Shell Configuration File:
o /etc/profile - used to set system wide environmental variables on
users shells. The variables are sometimes the same ones that are in the
.bash_profile, however this file is used to set an initial PATH or PS1 for
all shell users of the system. is only executed for interactive login
shells, or shells executed with the --login parameter.
o /etc/profile.d - /etc/profile will execute the scripts within
/etc/profile.d/*.sh. It is recommended to place your configuration in
a shell script within /etc/profile.d to set your own system wide
environmental variables.
o /etc/bashrc - System wide version of .bashrc. In Fedora derived
distributions, etc/bashrc also invokes /etc/profile.d/*.sh if non-login shell,
but redirects output to /dev/null if non-interactive. Is only executed for
interactive shells or if BASH_ENV is set to /etc/bashrc.
▪
•
User Shell Configuration Files:
•
•
~/.bash_profile - Is executed to configure your shell before the initial
command prompt. Is only read by login shells.
~/.bashrc - Is executed for interactive shells. only read by a shell that's both
interactive and non-login
umask is set by order of precedence. If umask is set in multiple locations, this order of
precedence will determine the system's default umask.
Order of precedence:
1. A file in /etc/profile.d/ ending in .sh - This will override any other systemwide umask setting
2. In the file /etc/profile
3. On the pam_umask.so module in /etc/pam.d/postlogin
4. In the file /etc/login.defs
5. In the file /etc/default/login

Rationale:
Setting a secure default value for umask ensures that users make a conscious choice
about their file permissions. A permissive umask value could result in directories or files
with excessive permissions that can be read and/or written to by unauthorized users.
Satisfies: SRG-OS-000480-GPOS-00228, SRG-OS-000480-GPOS-00227"
    local ATTACK=""
    local REMEDIATION="1. Run the following script to comment out all occurrences of umask that are less
restrictive than 027 in files ending in *.sh in the /etc/profile.d/ directory:
#!/usr/bin/env bash
{
while IFS= read -r -d \$'\0' l_file; do
sed -ri '/^\s*umask\s+0?(0[01][0-7]|0[0-7][^7]|[^0][0-7][07])(\s*|\s+.*)\$/s/^/# /' \"\$l_file\"
done < <(find /etc/profile.d/ -type f -name '*.sh' -print0)
}
2. Create or edit a file in /etc/profile.d/ ending in *.sh and add or modify the
following line:
umask 0027
Example:
# printf '%s\n' \"\" \"umask 027\" >> /etc/profile.d/60-default_umask.sh
3. Edit /etc/login.defs and add or update the following line:
UMASK 027
Notes:
• This method only applies to bash and shell. If other shells are supported on the
system, it is recommended that their configuration files also are checked
• If the pam_umask.so module is going to be used to set umask, ensure that it's not
being overridden by another setting. Refer to the PAM_UMASK(8) man page for
more information"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
