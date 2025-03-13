# backup-mac-to-pbs
This container/script combo lets you back up your Mac OS Machine to Proxmox Backup Server

# What you need
- Proxmox Backup Server installed and running on your network
- You will need a Mac device to back up
- Your Mac must have [Docker Desktop](https://docs.docker.com/desktop/setup/install/mac-install/) installed

# Process
- Clone this repo and update follwing files
- `docker-compose.yaml`
    - Update your local path (left of `:`) to include the directory you want to backup. No changes need on the right side.
    ```
    - /Volumes/Data/work/another-python:/backup
    ```
- `backup-mac-to-pbs.sh`
    - Update the values below
    - More info on these variables can be found on the [Proxmox Docuementation](https://pbs.proxmox.com/docs/backup-client.html)
    ```
    export PBS_REPOSITORY=
    export PBS_PASSWORD=
    export PBS_FINGERPRINT=
    ```
- Start the container. Navigate to this director on Terminal and run the following
    ```
    docker compose up -d --force-recreate
    ```
# Notes:
- This will run a backup hourly using crontab but will only do one backup per day
    - cronjob runs hourly in case if your machine was sleeping/off