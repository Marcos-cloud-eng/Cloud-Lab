# LAB 02 – Module 10 – Linux Users and Groups

## Scenario

A Linux server was prepared for a Cloud Administration environment. The objective was to create users, manage groups, configure permissions, and validate access to shared resources.

---

## Objectives

- Create Linux users
- Create Linux groups
- Assign users to groups
- Manage shared directories
- Configure file permissions
- Validate user access
- Understand Linux access control

---

## Environment

- Operating System: Ubuntu 24.04 LTS
- Virtualization: VMware Workstation Pro
- User: marcos

---

## Commands Used

```bash
sudo adduser clouduser
sudo groupadd cloudteam
sudo usermod -aG cloudteam clouduser

id clouduser
groups clouduser

sudo mkdir /cloud-team
sudo chgrp cloudteam /cloud-team
sudo chmod 770 /cloud-team

su - clouduser

touch teste.txt
ls
```

---

## Results

The following tasks were successfully completed:

- Created a new Linux user.
- Created a dedicated Cloud team group.
- Added the user to the appropriate group.
- Created a shared directory.
- Configured Linux permissions using chmod.
- Assigned the correct group ownership using chgrp.
- Successfully validated access using the new user account.

---

## Skills Learned

- Linux User Management
- Linux Group Management
- File Permissions
- Directory Ownership
- chmod
- chgrp
- Access Control
- Basic Linux Administration

---

## Evidence

Screenshots are available in:

screenshots/module-10/

---

## Conclusion

This laboratory simulated a real-world Linux administration scenario where users and groups were configured to provide controlled access to shared resources. The exercise reinforced fundamental concepts that are directly applicable to Cloud Administration and Infrastructure Management.
