#!/usr/bin/env bash
# controls/5.4.2.6_root_user_umask_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.2.6"
    local TITLE="Ensure root user umask is configured ((Automated)"
    local EXPECTED="Run the following command to verify that the root user files, /root/.profile and
/root/.bashrc, do not include a umask that is less restrictive than 0027:
# grep -Psi -- '^\h*umask\h+((\d{1,2}(\d[^7]|[^27]\d)\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[
wrx]{1,3},)?o=[wrx]{1,3}\b)))' /root/.profile /root/.bashrc
Nothing should be returned."
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
root user Shell Configuration Files:
•
•
/root/.profile - Is executed to configure the root users' shell before the initial
command prompt. Is only read by login shells.
/root/.bashrc - Is executed for interactive shells. only read by a shell that's
both interactive and non-login
umask is set by order of precedence. If umask is set in multiple locations, this order of
precedence will determine the system's default umask.
Order of precedence:
1. /root/.profile
2. /root/.bashrc
3. The system default umask

Rationale:
Setting a secure value for umask ensures that users make a conscious choice about
their file permissions. A permissive umask value could result in directories or files with
excessive permissions that can be read and/or written to by unauthorized users."
    local ATTACK=""
    local REMEDIATION="Edit /root/.profile and /root/.bashrc and either:
•
remove, comment out, or update any line with umask.
- OR •
update any line that includes umask to a value of 0027 or more restrictive.
Example:
umask 027
Note: the Recommendation \"Ensure default user umask is configured\" includes
guidance to set the default umask"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
