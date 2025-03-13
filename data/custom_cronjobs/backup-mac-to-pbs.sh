#!/bin/bash

# Following two will stay same for all VMs
cur_folder="/home/custom_cronjobs/"
backup_marker=$cur_folder"last-ran-backup"

# first check if backup was done today/date
if [[ $(date -r $backup_marker +%Y-%m-%d) == $(date +%Y-%m-%d) ]]; then
  # `date +%Y-%m-%d" "%H:%M:%S`": The backup was created earlier for today's date, so ignoring: "
  exit -1
fi

# run the backup now
echo "" # for newline in the log!
echo `date +%Y-%m-%d" "%H:%M:%S`": About to start the backup"

# update below 3 lines variables for your environment, if you don't know how to then follow Proxmox documentation: https://pbs.proxmox.com/docs/backup-client.html
export PBS_REPOSITORY=
export PBS_PASSWORD=
export PBS_FINGERPRINT=

proxmox-backup-client backup root.pxar:/backup
# if you want you can specify the NAMESPACE (--ns) and backup-id (--backup-id) if configured on Proxmox Backup Server
# proxmox-backup-client backup root.pxar:/backup --ns host --backup-id "mac-mini4"
if [ $? -ne 0 ]; then 
  echo `date +%Y-%m-%d" "%H:%M:%S`": **********************"; 
  echo `date +%Y-%m-%d" "%H:%M:%S`": *** Backup failed! ***"; 
  echo `date +%Y-%m-%d" "%H:%M:%S`": **********************"; 
else
  # now create the marker file to prevent the same day backup
  touch $backup_marker;
fi

# no changes needed below 3 lines!
export PBS_REPOSITORY=
export PBS_PASSWORD=
export PBS_FINGERPRINT=

echo `date +%Y-%m-%d" "%H:%M:%S`": Finished backup"
echo "" # for newline in the log!
