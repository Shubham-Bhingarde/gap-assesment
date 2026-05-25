#!/usr/bin/env bash
# controls/1.1.2.2.1_dev_shm_is_tmpfs_or_a_separate_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.2.1"
    local TITLE="Ensure /dev/shm is tmpfs or a separate partition ((Automated)"
    local EXPECTED="- IF - /dev/shm is to be used on the system, run the following command and verify the
output shows that /dev/shm is mounted. Particular requirements pertaining to mount
options are covered in ensuing sections.
# findmnt -kn /dev/shm
Example output:
/dev/shm
tmpfs
tmpfs
rw,nosuid,nodev,noexec,relatime,seclabel"
    local RISK="Unknown"
    local DESC="The /dev/shm directory is a world-writable directory that can function as shared
memory that facilitates inter process communication (IPC).

Rationale:
Making /dev/shm its own file system allows an administrator to set additional mount
options such as the noexec option on the mount, making /dev/shm useless for an
attacker to install executable code. It would also prevent an attacker from establishing a
hard link to a system setuid program and wait for it to be updated. Once the program
was updated, the hard link would be broken and the attacker would have his own copy
of the program. If the program happened to have a security vulnerability, the attacker
could continue to exploit the known flaw.
This can be accomplished by mounting tmpfs to /dev/shm."
    local ATTACK="Since the /dev/shm directory is intended to be world-writable, there is a risk of resource
exhaustion if it is not bound to a separate partition.
/dev/shm utilizing tmpfs can be resized using the size={size} parameter in the
relevant entry in /etc/fstab."
    local REMEDIATION="For specific configuration requirements of the /dev/shm mount for your environment,
modify /etc/fstab.
Example:
tmpfs
/dev/shm
tmpfs
defaults,rw,nosuid,nodev,noexec,relatime,size=2G
0 0"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
