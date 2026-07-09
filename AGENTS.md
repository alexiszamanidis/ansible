# AGENTS.md

## Overview

Personal Ansible playbook that provisions a local Ubuntu/WSL development machine: packages, dotfiles, Neovim, Node/Java tooling, and work-specific setup via the `ansible-work` submodule role.

## Stack

| Tool                | Role                                       |
| ------------------- | ------------------------------------------ |
| Ansible             | Playbook execution (`local.yml`, `tasks/`) |
| YAML                | Playbooks, tasks, variables                |
| Python 3.11         | Ansible runtime, CI linting                |
| Prettier            | YAML/Markdown formatting                   |
| ansible-lint 25.5.0 | Playbook linting                           |
| Docker Compose      | Test runs in a container                   |

## Commands

```bash
# Bootstrap Ansible on a fresh machine
chmod +x ansible && ./ansible

# Full install (requires ~/.vault_pass.txt — see README.md)
ansible-playbook -t install local.yml

# Run a tagged subset only
ansible-playbook -t core local.yml
ansible-playbook -t nvim local.yml

# Format and lint (run before committing)
npm run format
ansible-lint --fix -c ./.ansible-lint

# Test in Docker
docker-compose build && docker-compose up -d
docker exec -it ansible bash
```

## Layout

```
local.yml              # Main playbook (localhost)
tasks/                 # Task files imported by local.yml (one concern per file)
group_vars/all.yml     # Shared variables (paths, package lists, WSL detection)
roles/ansible-work/    # Git submodule — work env, credentials templates, work apps
ansible.cfg            # Vault password file path, defaults
```

New install tasks belong in `tasks/<name>.yml` and are imported from `local.yml` with an `install` tag (and a specific tag for selective runs).

## Conventions

-   Use `ansible.builtin.*` module FQCNs.
-   Tag tasks with `install` plus a component tag (e.g. `core`, `nvim`, `work`).
-   Guard platform-specific tasks with `when: is_wsl` or `when: not is_wsl` (see `group_vars/all.yml`).
-   Work-specific changes go in the `ansible-work` submodule, not the root playbook.
-   Root `.ansible-lint` excludes `roles/ansible-work/`; that role has its own lint config.

## Boundaries

| Always                                                     | Never                                                | Ask first                                                                        |
| ---------------------------------------------------------- | ---------------------------------------------------- | -------------------------------------------------------------------------------- |
| Run `npm run format` and `ansible-lint` after YAML changes | Commit secrets, vault files, or `~/.vault_pass.txt`  | Modify credential templates in `roles/ansible-work/templates/credentials/`       |
| Keep task files focused (one tool/concern per file)        | Edit `.ssh/id_rsa` or other private keys in the repo | Change `ansible-work` submodule URL or work-specific vars                        |
| Use Ansible Vault for sensitive values                     | Remove or weaken vault usage                         | Run `ansible-playbook` against remote hosts (this repo targets `localhost` only) |
