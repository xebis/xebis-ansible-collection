# IAM

## Example Configuration

```yaml
# group_vars/all.yml
users:
# - username: alice
#   admin: BOOL
#   [ssh_keys_urls]: list of URLs pointing to public SSH key list, for example https://github.com/user.keys or https://gitlab.com/user.keys
#   [ssh_keys]: list of public SSH keys
  - username: bob
    admin: true
    ssh_keys_urls:
      - https://gitlab.com/bob.keys
      - https://github.com/bob.keys
  - username: charlie
    admin: false
    ssh_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAQQCo9+BpMRYQ/dL3DS2CyJxRF+j6ctbT3/Qp84+KeFhnii7NT7fELilKUSnxS30WAvQCCo2yU1orfgqr41mM70MB example-openssh-key
```
