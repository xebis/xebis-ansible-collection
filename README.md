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
  - [Supported OS](#supported-os)
- [Installation and Configuration](#installation-and-configuration)
- [Usage](#usage)
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

Ansible roles:

- [`xebis.ansible.system`](roles/system): well maintained operating system - updates and upgrades `deb` packages including autoremove and autoclean, reboots the system (when necessary), provides `Reboot machine` handler
- [`xebis.ansible.system_management`](roles/system_management): operating system management essential - installs and set ups `at`
- [`xebis.ansible.engineering`](roles/engineering): engineering essentials - installs and set ups `direnv`

### Supported OS

`Ubuntu Server 22.04` and `Kubuntu 22.04` are supported.

## Installation and Configuration

Install the collection using `ansible-galaxy collection install git@github.com/xebis/xebis-ansible-collection.git`, or you can use `requirements.yml` and install it with `ansible-galaxy install -r requirements.yml`:

```yaml
collections:
  - git@github.com/xebis/xebis-ansible-collection.git
```

## Usage

In an Ansible playbook:

```yaml
  roles:
    - role: xebis.ansible.role
```

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
  - [ ] [`scripts/secrets.sh`](scripts/secrets.sh)
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

Run the container:

```bash
sudo docker run -it --rm -v "$(pwd)":/repository-template alpine:latest # Create disposal docker container
```

In the container:

```bash
cd repository-template
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
