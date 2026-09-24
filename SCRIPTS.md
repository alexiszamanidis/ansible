### Scripts

`install`

Installs Ansible if it is missing, creates `~/.vault_pass.txt` if it is missing, installs Galaxy collections if they are missing, then runs `local.yml`.

`sync-apps`

Scans bash history for installed applications and adds an Ansible task for any that are missing from this repository.
