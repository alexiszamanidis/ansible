## Ansible

This repository installs packages and applications that I use in my daily work

### Installation

1. Clone the repository and run the install script

```
git clone https://github.com/alexiszamanidis/ansible.git ~/ansible && \
cd ~/ansible && \
git remote set-url origin git@github.com:alexiszamanidis/ansible.git && \
./install
```

This installs Ansible, creates `~/.vault_pass.txt` if it is missing, then runs the playbook. You will be prompted for the vault password when needed, then for your sudo password.

2. Restart the terminal so nvm, SDKMAN, and shell changes load.

### Reminders

**Make sure that your machine can run the tasks. You can check it with the following Docker commands:**

1. Build the image

```
docker-compose build
```

2. Run the container

```
docker-compose up
```

3. Access the container

```
docker exec -it ansible bash
```

#### External Applications

-   VSCode: Sign in via GitHub
-   Excalidraw: Download as PWA
