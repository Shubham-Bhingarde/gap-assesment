#!/usr/bin/env bash
# controls/1.1.2.1.1_tmp_is_tmpfs_or_a_separate_partition.sh

execute_control() {
    local CONTROL_ID="1.1.2.1.1"
    local TITLE="Ensure /tmp is tmpfs or a separate partition ((Automated)"
    local EXPECTED="Run the following command and verify the output shows that /tmp is mounted.
Particular requirements pertaining to mount options are covered in ensuing sections.
# findmnt -kn /tmp
Example output:
/tmp
tmpfs
tmpfs
rw,nosuid,nodev,noexec
Ensure that systemd will mount the /tmp partition at boot time.
# systemctl is-enabled tmp.mount
Example output:
generated
Verify output is not masked or disabled.
Note: By default, systemd will output generated if there is an entry in /etc/fstab for
/tmp. This just means systemd will use the entry in /etc/fstab instead of its default
unit file configuration for /tmp."
    local RISK="Unknown"
    local DESC="The /tmp directory is a world-writable directory used for temporary storage by all users
and some applications.
Note: If an entry for /tmp exists in /etc/fstab it will take precedence over entries in a
systemd unit file. There is an exception to this when a system is diskless and connected
to iSCSI, entries in /etc/fstab may not take precedence over a systemd unit file.

Rationale:
Making /tmp its own file system allows an administrator to set additional mount options
such as the noexec option on the mount, making /tmp useless for an attacker to install
executable code. It would also prevent an attacker from establishing a hard link to a
system setuid program and wait for it to be updated. Once the program was updated,
the hard link would be broken, and the attacker would have his own copy of the
program. If the program happened to have a security vulnerability, the attacker could
continue to exploit the known flaw.
This can be accomplished by either mounting tmpfs to /tmp, or creating a separate
partition for /tmp."
    local ATTACK="By design files saved to /tmp should have no expectation of surviving a reboot of the
system. tmpfs is ram based and all files stored to tmpfs will be lost when the system is
rebooted.
If files need to be persistent through a reboot, they should be saved to /var/tmp not
/tmp.
Since the /tmp directory is intended to be world-writable, there is a risk of resource
exhaustion if it is not bound to tmpfs or a separate partition.
Running out of /tmp space is a problem regardless of what kind of filesystem lies under
it, but in a configuration where /tmp is not a separate file system it will essentially have
the whole disk available, as the default installation only creates a single / partition. On
the other hand, a RAM-based /tmp (as with tmpfs) will almost certainly be much
smaller, which can lead to applications filling up the filesystem much more easily.
Another alternative is to create a dedicated partition for /tmp from a separate volume or
disk. One of the downsides of a disk-based dedicated partition is that it will be slower
than tmpfs which is RAM-based."
    local REMEDIATION="First ensure that systemd is correctly configured to ensure that /tmp will be mounted at
boot time.
# systemctl unmask tmp.mount
For specific configuration requirements of the /tmp mount for your environment, modify
/etc/fstab.
Example of using tmpfs with specific mount options:
tmpfs
0
/tmp
tmpfs
defaults,rw,nosuid,nodev,noexec,relatime,size=2G
0
Note: the size=2G is an example of setting a specific size for tmpfs.
Example of using a volume or disk with specific mount options. The source location of
the volume or disk will vary depending on your environment:
<device> /tmp
<fstype>
defaults,nodev,nosuid,noexec
0 0"

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/tmp" 2>/dev/null)
    local SYSTEMD_CHECK=$(systemctl is-enabled $(systemd-escape --suffix=mount "/tmp") 2>/dev/null || echo "")

    if [ -n "$MOUNT_CHECK" ]; then
        CURRENT="/tmp is mounted. Systemd status: ${SYSTEMD_CHECK:-unknown}"
        RESULT="PASS"
    else
        CURRENT="/tmp is not mounted as a separate partition or tmpfs."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
