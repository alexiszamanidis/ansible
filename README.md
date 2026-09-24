## Ansible

This repository installs packages and applications that I use in my daily work

### Installation

```
git clone https://github.com/alexiszamanidis/ansible.git ~/ansible && \
cd ~/ansible && \
git remote set-url origin git@github.com:alexiszamanidis/ansible.git && \
./install
```

You will be prompted for the vault password when needed, then for your sudo password. Restart the terminal so nvm, SDKMAN, and shell changes load.

### Docker smoke test

Requires `~/.vault_pass.txt`. `USERNAME` defaults to `alexzam`, `USER_ID` to `1000`, and `SKIP_TAGS` to `work`. Set them to override. GitHub Actions runs the same test only when you start the `docker-test` workflow.

```
docker compose up --build
```

### Reminders

#### External Applications

-   VSCode: Sign in via GitHub
-   Excalidraw: Download as PWA
