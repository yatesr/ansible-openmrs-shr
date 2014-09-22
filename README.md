Role Name
========

ansible-openmrs-shr

** Work In Progress**
TODO:
implement non deploy

Role Variables
--------------
```
# Deploy a local module
openmrs_shr_deploy: false
# local folder modules to be deployed are located.
openmrs_shr_modules_dir:
# Location on remote host where modules will be copied to.
openmrs_modules_dir: "{{usr_tomcat}}/.OpenMRS/modules"

# Database setup **These variables need to be in your playbook to be used in both the ansible-openmrs role and this role.**
openmrs_db_name: openmrs
openmrs_db_user: openmrs_user
openmrs_db_user_password: openmrs_user
# Dont change this unless you already have mysql setup
openmrs_db_login_user: root
openmrs_db_login_password: root

```

Example Playbook
-------------------------
### playbook.yml

```

---
- hosts: all
  roles:
  - ansible-openmrs
  - ansible-openmrs-shr

  vars:
    openmrs_db_name: openmrs
    openmrs_db_user: openmrs_user
    openmrs_db_user_password: secret
    openmrs_db_login_user: root
    openmrs_db_login_password: supersecret

```

License
-------

Apache 2.0

Author Information
------------------

Ryan Yates
