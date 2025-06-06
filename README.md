## Ansible

This repository installs packages and applications that I use in my daily work

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

- VSCode: Sign in via GitHub
- Excalidraw: Download as PWA

### Installation

1. Create `~/.vault_pass.txt` file, lock it down and clear the bash history

```
echo "my-vault-password" > ~/.vault_pass.txt && \
chmod 0600 ~/.vault_pass.txt && \
history -c
```

2. Clone the repository and install ansible

```
git clone https://github.com/alexiszamanidis/ansible.git ~/ansible && \
cd ~/ansible && \
git remote set-url origin git@github.com:alexiszamanidis/ansible.git && \
chmod +x ansible sync-apps && ./ansible
```

3. Start the installation process

```
ansible-playbook -t install local.yml
```

3. Restart the terminal

4. Install java and node and manage them via their version managers

```
sdk install java && \
nvm install 16.16.0 && nvm use --delete-prefix v16.16.0 && nvm alias default 16.16.0
```
