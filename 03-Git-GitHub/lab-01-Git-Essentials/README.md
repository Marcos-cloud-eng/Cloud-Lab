# Lab 01 - Git Essentials on Ubuntu

## Objective

Install Git on Ubuntu, configure a local Git environment and connect to a GitHub repository.

---

## Environment

Host Operating System:
Windows 11

Virtualization:
VMware Workstation Pro

Guest Operating System:
Ubuntu Desktop

Repository:
Cloud-Lab

---

## Installing Git

Update the package list.

```bash
sudo apt update
```

Install Git.

```bash
sudo apt install git -y
```

Verify the installation.

```bash
git --version
```

---

## Git Configuration

Configure your username.

```bash
git config --global user.name "Marcos França"
```

Configure your email.

```bash
git config --global user.email "your-email@example.com"
```

Verify the configuration.

```bash
git config --list
```

---

## Cloning the Repository

Clone the repository.

```bash
git clone https://github.com/Marcos-cloud-eng/Cloud-Lab.git
```

Enter the project folder.

```bash
cd Cloud-Lab
```

---

## Basic Git Commands

Check repository status.

```bash
git status
```

Add files.

```bash
git add .
```

Create a commit.

```bash
git commit -m "Complete Git Essentials Lab"
```

Upload changes.

```bash
git push
```

---

## Skills Practiced

- Installing Git
- Configuring Git
- Cloning a repository
- Using the Linux terminal
- Creating commits
- Pushing changes to GitHub

---

## What I Learned

- How Git works.
- How Git integrates with GitHub.
- How to configure Git on Linux.
- Basic Git workflow.
- Why version control is essential for Cloud Engineers.

---

## Next Lab

Lab 02 - Linux File System
