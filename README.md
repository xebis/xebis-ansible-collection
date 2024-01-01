<!-- omit in toc -->
# Xebis Ansible Collection

![GitHub top language](https://img.shields.io/github/languages/top/xebis/xebis-ansible-collection)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

![GitHub](https://img.shields.io/github/license/xebis/xebis-ansible-collection)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/xebis/xebis-ansible-collection)
![GitHub issues](https://img.shields.io/github/issues/xebis/xebis-ansible-collection)
![GitHub last commit](https://img.shields.io/github/last-commit/xebis/xebis-ansible-collection)
[![pipeline status](https://gitlab.com/xebis/xebis-ansible-collection/badges/main/pipeline.svg?ignore_skipped=true)](https://gitlab.com/xebis/xebis-ansible-collection/-/commits/main)

A collection of Xebis shared Ansible roles.

**The project is under active development.**

<!-- omit in toc -->
## Table of Contents

- [Features](#features)
  - [Ansible Roles](#ansible-roles)
  - [Supported OS](#supported-os)
- [Installation and Configuration](#installation-and-configuration)
- [Usage](#usage)
  - [Caveats](#caveats)
- [Contributing](#contributing)
  - [Development](#development)
  - [Testing](#testing)
    - [Test at Docker Container](#test-at-docker-container)
- [Credits and Acknowledgments](#credits-and-acknowledgments)
- [Copyright and Licensing](#copyright-and-licensing)
- [Changelog and News](#changelog-and-news)
- [Notes and References](#notes-and-references)
  - [Dependencies](#dependencies)
  - [Recommendations](#recommendations)
  - [Suggestions](#suggestions)
  - [Further Reading](#further-reading)

## Features

### Ansible Roles

| Role | Description | Documentation | Dependencies | |
|---|---|---|---|---|
| [`xebis.ansible.system`](roles/system) | Well maintained operating system | Updates and upgrades `deb` packages including autoremove and autoclean, reboots the system (when necessary), provides `Reboot machine` handler |
| [`xebis.ansible.firewall`](roles/firewall) | Extensible nftables firewall | Installs `nftables` and sets up basic extensible nftables chains and rules, provides `Revalidate and reload nftables` and `Reload nftables` handlers, see [Firewall role README.md](roles/firewall/README.md) for usage, configuration, and examples | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.fail2ban`](roles/fail2ban) | Fail2ban service | Installs `fail2ban` and sets it up as a systemd service | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) |
| [`xebis.ansible.iam`](roles/iam) | IAM | Creates user groups and users as regular users or admins, their public SSH keys, disables password remote logins, provides `Restart sshd` handler, see [IAM role README.md](roles/iam/README.md) for usage, configuration, and examples | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) [`xebis.ansible.fail2ban`](roles/fail2ban) |
| [`xebis.ansible.bash`](roles/bash) | Extensible Bash | Installs `~/.bash_aliases` and sets up basic extensible Bash aliases, see [Bash role README.md](roles/bash/README.md) for usage, configuration, and examples | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.admin`](roles/admin) | Administration essentials | Installs and sets up `at`, `curl`, `htop`, `mc`, `screen` | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.starship`](roles/starship) | Starship CLI prompt | Installs `starship` and sets up improved PowerLine configuration | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.docker`](roles/docker) | Docker essentials | Installs `docker-ce`, `docker-ce-cli`, `containerd.io`, `docker-buildx-plugin`, `docker-compose-plugin` from Docker apt repository, sets up `nftables` firewall for Docker **⚠ firewall rules are not production ready**, and prunes `builder cache`, `containers`, `images` including `non-dangling`, `networks` and `volumes` | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) |
| [`xebis.ansible.flatpak`](roles/flatpak) | Well maintained Flatpak | Updates and upgrades `Flatpak` packages including removing unused ones | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.physical`](roles/physical) | Physical machine essentials | Installs `hwinfo`, sets up to show GRUB menu with 3s timeout, and sets up `/tmp` in tmpfs, provides `Update GRUB configuration` handler | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.engineering`](roles/engineering) | Engineering essentials | Installs and sets up `direnv` | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.kde`](roles/kde/) | KDE essentials | Installs `krusader` (including recommended dependencies `kdiff3`, `kget`, and `krename`), `kwin-bismuth`, sets up `nftables` firewall for KDE, and provides `Plasma Reload` desktop icon | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) |
| [`xebis.ansible.multimedia`](roles/multimedia) | Multimedia essentials | Installs `audacity`, `darktable`, `digikam`, `exfat-fuse`, `exfatprogs`, `gimp`, and `rawtherapee` |[`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.slack`](roles/slack) | Slack | Installs `slack` ||
| [`xebis.ansible.thunderbird`](roles/thunderbird) | Thunderbird | Installs `thunderbird` and sets up `nftables` firewall for Thunderbird | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) |
| [`xebis.ansible.steam`](roles/steam) | Steam | Installs `steam-installer` | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) |
| [`xebis.ansible.openttd`](roles/openttd) | OpenTTD (transport simulation game) | Installs `OpenTTD` including `openttd-opensfx` | [`xebis.ansible.system`](roles/system) |
| [`xebis.ansible.widelands`](roles/widelands) | Widelands (real-time strategy game) | Installs `Widelands` and setups firewall | [`xebis.ansible.system`](roles/system) [`xebis.ansible.firewall`](roles/firewall) [`xebis.ansible.flatpak`](roles/flatpak) |

### Supported OS

`Ubuntu Server 22.04` and `Kubuntu 22.04` are supported.

## Installation and Configuration

Install the collection using `ansible-galaxy collection install git@github.com/xebis/xebis-ansible-collection.git`, or you can use `requirements.yml` and install it with `ansible-galaxy install -r requirements.yml`:

```yaml
collections:
  - name: git+https://github.com/xebis/xebis-ansible-collection.git,main
```

## Usage

In an Ansible playbook:

```yaml
  roles:
    - role: xebis.ansible.role
```

- [IAM usage, configuration, and examples](roles/iam/README.md)
- [Firewall usage, configuration, and examples](roles/firewall/README.md)

### Caveats

When a role is removed from a playbook, actions performed by the role are not reverted. This might lead to security risks and unexpected results, for example:

- `xebis.ansible.iam` might leave users and their access on the system
- `xebis.ansible.firewall` leaves firewall installed on the system
- a role with dependency on `xebis.ansible.firewall` might leave unwanted firewall rules on the system

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting merge requests to us.

### Development

Local collection testing:

```bash
ansible-galaxy collection build --force # Outputs collection build file
ansible-galaxy collection install --force /path/to/xebis-ansible-collection/xebis-ansible-version.tar.gz
```

### Testing

- Git hooks check a lot of things for you, including running automated tests `scripts/test full`
- Make sure all `scripts/*`, git hooks, and GitLab pipelines work as expected, testing checklist:

- `scripts/*` scripts - covered by unit tests `tests/*`
  - [ ] [`scripts/bootstrap`](scripts/bootstrap)
  - [ ] [`scripts/pre-commit`](scripts/pre-commit)
  - [ ] [`scripts/pre-push`](scripts/pre-push)
  - [ ] [`scripts/setup`](scripts/setup)
  - [ ] [`scripts/test`](scripts/test)
  - [ ] [`scripts/update`](scripts/update)
- Local working directory
  - [ ] `git commit` runs `pre-commit` hook-type `commit-msg` and [`scripts/pre-commit`](scripts/pre-commit)
  - [ ] `git merge`
    - [ ] Fast-forward shouldn't run any hooks or scripts
    - [ ] Automatically resolved `merge commit` runs `pre-commit` hook-type `commit-msg` and [`scripts/pre-commit`](scripts/pre-commit)
    - [ ] Manually resolved `merge commit` runs `pre-commit` hook-type `commit-msg` and [`scripts/pre-commit`](scripts/pre-commit)
  - [ ] `git push` runs [`scripts/pre-push`](scripts/pre-push)
  - [ ] `pre-commit run -a --hook-stage manual` runs all hooks and `check-hooks-apply` hook fails on `check-symlinks` and `forbid-binary`
- GitLab CI
  - [ ] Commit in _non_-`main` branch runs `validate:lint` and `validate:test-full`
  - [ ] Merge to `main` branch runs `validate:lint`, `validate:test-full`, and `release:release`
    - [ ] With a new `feat` or `fix` commit releases a new version
    - [ ] Without a new feature or fix commit does not release a new version
  - [ ] Scheduled (nightly) pipeline runs `validate:lint` and `validate:test-nightly`

#### Test at Docker Container

To test your changes in a different environment, you might try to run a Docker container and test it from there.

Run a disposal Docker container:

- `sudo docker run -it --rm -v "$(pwd)":/xebis-ansible-collection alpine:latest`
- `sudo docker run -it --rm -v "$(pwd)":/xebis-ansible-collection --entrypoint sh node:alpine`

In the container:

```bash
cd xebis-ansible-collection
# Set variables GL_TOKEN and GH_TOKEN when needed
# Put here commands from .gitlab-ci.yml job:before_script and job:script
# For example job test-full:
apk -U upgrade
apk add bats
bats tests
# Result is similar to:
# 1..1
# ok 1 dummy test
```

## Credits and Acknowledgments

- [Martin Bružina](https://bruzina.cz/) - Author

## Copyright and Licensing

- [MIT License](LICENSE)
- Copyright © 2023 Martin Bružina

## Changelog and News

- [Changelog](../CHANGELOG.md)

## Notes and References

### Dependencies

- [Ansible](https://www.ansible.com/)
  - [GitHub - ansible-community/ansible-lint: Best practices checker for Ansible](https://github.com/ansible-community/ansible-lint)
- [checkov](https://www.checkov.io/)
- [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template) - contains GitLab CI/CD, set of useful scripts, `pre-commit`, `semantic-release`, and `Visual Studio Code` suggested extensions

### Recommendations

- [GitHub - KeyboardInterrupt/awesome-ansible: Awesome Ansible List](https://github.com/KeyboardInterrupt/awesome-ansible)
- [Shields.io: Quality metadata badges for open source projects](https://shields.io/)

### Suggestions

- [Visual Studio Code](https://code.visualstudio.com/) with [Extensions for Visual Studio Code](https://marketplace.visualstudio.com/VSCode):
  - [Ansible](https://marketplace.visualstudio.com/items?itemName=redhat.ansible) - includes potentially unwanted extensions [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) (Ansible dependency) and [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance) (could be uninstalled)

### Further Reading

_List further reading links here, or delete the section._

- [Wikipedia: README](https://en.wikipedia.org/wiki/README)
- [Make a README: Because no one can read your mind (yet)](https://www.makeareadme.com/)
