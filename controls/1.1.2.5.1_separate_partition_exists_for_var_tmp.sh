#!/usr/bin/env bash
# controls/1.1.2.5.1_separate_partition_exists_for_var_tmp.sh

execute_control() {
    local CONTROL_ID="1.1.2.5.1"
    local TITLE="Ensure separate partition exists for /var/tmp ((Automated)"
    local EXPECTED="Run the following command and verify output shows /var/tmp is mounted.
Example:
# findmnt -kn /var/tmp
/var/tmp
/dev/sdb ext4
rw,nosuid,nodev,noexec,relatime,seclabel"
    local RISK="Unknown"
    local DESC="The /var/tmp directory is a world-writable directory used for temporary storage by all
users and some applications. Temporary files residing in /var/tmp are to be preserved
between reboots.

Rationale:
The default installation only creates a single / partition. Since the /var/tmp directory is
world-writable, there is a risk of resource exhaustion. In addition, other operations on
the system could fill up the disk unrelated to /var/tmp and cause potential disruption to
daemons as the disk is full.
Configuring /var/tmp as its own file system allows an administrator to set additional
mount options such as noexec/nosuid/nodev. These options limit an attacker's ability
to create exploits on the system."
    local ATTACK="Resizing filesystems is a common activity in cloud-hosted servers. Separate filesystem
partitions may prevent successful resizing or may require the installation of additional
tools solely for the purpose of resizing operations. The use of these additional tools may
introduce their own security considerations."
    local REMEDIATION="For new installations, during installation create a custom partition setup and specify a
separate partition for /var/tmp.
For systems that were previously installed, create a new partition and configure
/etc/fstab as appropriate."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
