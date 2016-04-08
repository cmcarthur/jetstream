### Installation

Run:

```
cp state/variables.tfvars.example state/variables.tfvars
```

Then, edit the file appropriately and run `make plan`.

### TODOs

- Write `configure` CLI for:
  - SSH key
  - AWS credentials
  - Usernames & Passwords
  - Switching DNS on/off
- Create an /etc/hosts on bastion with all of the hostnames for generated instances
