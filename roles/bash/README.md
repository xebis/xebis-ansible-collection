# Bash Role

<!-- cSpell:ignore myip Linuxize ipinfo -->

The role installs [`~/.bash_aliases`](files/.bash_aliases) and sets up basic extensible nftables aliases.

## Extending Aliases

To extend aliases simply put Bash aliases files to `~/.config` directory, the file naming convention is `name.bash_aliases`. Aliases are loaded automatically next Bash execution.

### Example File

```bash
alias myip='curl ipinfo.io/ip'
```

### Example of Use in a Role

Add a role dependency in `meta` file:

```yaml
---
dependencies:
  - role: xebis.ansible.bash # Expects extensible Bash aliases in place
```

Create alias file, for example `role.bash_aliases`.

Add Ansible task to copy files to `~/.config`, for example:

```yaml
- name: Copy role Bash aliases
  ansible.builtin.copy:
    src: role.bash_aliases
    dest: ~/.config/role.bash_aliases
    mode: u=rw,g=r,o=r
```

## References

- [Linuxize: How to Create Bash Aliases](https://linuxize.com/post/how-to-create-bash-aliases/)
