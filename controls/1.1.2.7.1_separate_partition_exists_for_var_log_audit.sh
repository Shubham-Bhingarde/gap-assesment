#!/usr/bin/env bash
# controls/1.1.2.7.1_separate_partition_exists_for_var_log_audit.sh

execute_control() {
    local CONTROL_ID="1.1.2.7.1"
    local TITLE="Ensure separate partition exists for /var/log/audit ((Automated)"
    local EXPECTED="Run the following command and verify output shows /var/log/audit is mounted:
# findmnt -kn /var/log/audit
/var/log/audit /dev/sdb ext4
rw,nosuid,nodev,noexec,relatime,seclabel"
    local RISK="Unknown"
    local DESC="The auditing daemon, auditd, stores log data in the /var/log/audit directory.

Rationale:
The default installation only creates a single / partition. Since the /var/log/audit
directory contains the audit.log file which can grow quite large, there is a risk of
resource exhaustion. It will essentially have the whole disk available to fill up and impact
the system as a whole. In addition, other operations on the system could fill up the disk
unrelated to /var/log/audit and cause auditd to trigger its space_left_action as
the disk is full. See man auditd.conf for details.
Configuring /var/log/audit as its own file system allows an administrator to set
additional mount options such as noexec/nosuid/nodev. These options limit an
attacker's ability to create exploits on the system. Other options allow for specific
behavior. See man mount for exact details regarding filesystem-independent and
filesystem-specific options.
As /var/log/audit contains audit logs, care should be taken to ensure the security
and integrity of the data and mount point."
    local ATTACK="Resizing filesystems is a common activity in cloud-hosted servers. Separate filesystem
partitions may prevent successful resizing or may require the installation of additional
tools solely for the purpose of resizing operations. The use of these additional tools may
introduce their own security considerations."
    local REMEDIATION="For new installations, during installation create a custom partition setup and specify a
separate partition for /var/log/audit.
For systems that were previously installed, create a new partition and configure
/etc/fstab as appropriate."

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/var/log/audit" 2>/dev/null)
    local SYSTEMD_CHECK=$(systemctl is-enabled $(systemd-escape --suffix=mount "/var/log/audit") 2>/dev/null || echo "")

    if [ -n "$MOUNT_CHECK" ]; then
        CURRENT="/var/log/audit is mounted. Systemd status: ${SYSTEMD_CHECK:-unknown}"
        RESULT="PASS"
    else
        CURRENT="/var/log/audit is not mounted as a separate partition or tmpfs."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
