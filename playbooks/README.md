# Ansible playbooks for server management
Here we have playbooks and [Ansible](https://docs.ansible.com/ansible/latest) configuration necessary to deploy and manage a remote EpiGraphHub server.

## Playbooks
Each playbook takes care of the deploy of a specific component of the Hub's architecture.
### PostgreSQL
In order to run this playbook, you  need to create your own encrypted vars.yml file, and run the command below. You may also need to edit the `hosts.ini` file, to suit your needs.
```bash
$ ansible-playbook --ask-vault-password -K postgresql.yml
```
