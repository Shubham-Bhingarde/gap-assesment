#!/usr/bin/env bash
# controls/1.1.2.4.1_separate_partition_exists_for_var.sh

execute_control() {
    local CONTROL_ID="1.1.2.4.1"
    local TITLE="Ensure separate partition exists for /var ((Automated)"
    local EXPECTED="Run the following command and verify output shows /var is mounted.
Example:
# findmnt -kn /var
/var
/dev/sdb
ext4
rw,nosuid,nodev,relatime,seclabel"
    local RISK="Unknown"
    local DESC="The /var directory is used by daemons and other system services to temporarily store
dynamic data. Some directories created by these processes may be world-writable.

Rationale:
The reasoning for mounting /var on a separate partition is as follows.
The default installation only creates a single / partition. Since the /var directory may
contain world writable files and directories, there is a risk of resource exhaustion. It will
essentially have the whole disk available to fill up and impact the system. In addition,
other operations on the system could fill up the disk unrelated to /var and cause
unintended behavior across the system as the disk is full. See man auditd.conf for
details.
Configuring /var as its own file system allows an administrator to set additional mount
options such as noexec/nosuid/nodev. These options limit an attacker's ability to
create exploits on the system. Other options allow for specific behavior. See man mount
for exact details regarding filesystem-independent and filesystem-specific options.
An example of exploiting /var may be an attacker establishing a hard-link to a system
setuid program and waiting for it to be updated. Once the program is updated, the
hard-link can be broken and the attacker would have their own copy of the program. If
the program happened to have a security vulnerability, the attacker could continue to
exploit the known flaw."
    local ATTACK="Resizing filesystems is a common activity in cloud-hosted servers. Separate filesystem
partitions may prevent successful resizing or may require the installation of additional
tools solely for the purpose of resizing operations. The use of these additional tools may
introduce their own security considerations."
    local REMEDIATION="For new installations, during installation create a custom partition setup and specify a
separate partition for /var.
For systems that were previously installed, create a new partition and configure
/etc/fstab as appropriate."

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/var" 2>/dev/null)
    local SYSTEMD_CHECK=$(systemctl is-enabled $(systemd-escape --suffix=mount "/var") 2>/dev/null || echo "")

    if [ -n "$MOUNT_CHECK" ]; then
        CURRENT="/var is mounted. Systemd status: ${SYSTEMD_CHECK:-unknown}"
        RESULT="PASS"
    else
        CURRENT="/var is not mounted as a separate partition or tmpfs."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
