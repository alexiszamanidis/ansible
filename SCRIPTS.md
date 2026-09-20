### Scripts

`install`

This script installs Ansible, creates `~/.vault_pass.txt` if it is missing, then runs the playbook.

`sync-apps`

At times, I may have installed software on my machine without updating the corresponding repository,
leading to outdated Ansible tasks. To mitigate this, this script scans my bash history for installed
applications, checks if these applications are not included in my current Ansible tasks and generatesa
a new installation task for them if necessary.
