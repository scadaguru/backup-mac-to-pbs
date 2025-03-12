# backup-mac-to-pbs
Do backup of your MAC OS to Proxmox Backup Server

## This repo will allow you to do backup of your MAC OS to Proxmox Backup Server.
### You will need:
- Proxmox Backup Server installed and running somewhere in your network
- You will need a MAC device to backup of it's folder to the Proxmox Backup Server
- Your MAC must have Docker Desktop offical application installed

### Clone this repo and update follwing files
- docker-compose.yaml line #13 shown below:
    Make changes on the left side to point your folder that you want to get backup of, no changes need on the right side.
    - /Volumes/Data/work/another-python:/backup
- using terminal CD to that folder run the following command
    docker compose up -d --force-recreate

### Notes:
- This will run backup at every hour using crontab but will do only one backup per day, cronjob runs hourly in case if your MAC was sleeping or not on so it will get backuped next hour if it is still on once a day