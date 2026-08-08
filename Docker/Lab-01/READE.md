# Docker Lab 01 - Docker Engine Setup on Ubuntu

## Scenario

This lab demonstrates the installation and initial configuration of Docker Engine on Ubuntu Linux, followed by the execution and management of basic containers.

## Objectives

- Install Docker Engine on Ubuntu
- Configure the official Docker repository
- Validate the Docker service
- Run the first container
- Inspect Docker images and containers
- Create an interactive Ubuntu container
- Start, stop, and access an existing container
- Validate container data persistence after restart

## Environment

- Operating System: Ubuntu Linux
- Architecture: x86_64
- Virtualization: VMware
- Repository: Cloud-Lab
- Lab: Docker / Lab-01

## Initial Validation

```bash
cat /etc/os-release
uname -m
docker --version
```

The initial validation confirmed that Docker was not installed.

## Docker Repository Configuration

```bash
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

The official Docker repository was then added to the system.

## Docker Engine Installation

```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Validation:

```bash
docker --version
sudo systemctl status docker
```

## First Container

The first Docker container was executed with:

```bash
sudo docker run hello-world
```

Docker automatically downloaded the `hello-world` image from Docker Hub and created a container from it.

Container validation:

```bash
sudo docker ps
sudo docker ps -a
sudo docker images
```

## Interactive Ubuntu Container

An Ubuntu container was created:

```bash
sudo docker run -it --name ubuntu-lab ubuntu bash
```

Inside the container:

```bash
whoami
cat /etc/os-release
hostname
pwd
ls
```

This confirmed that the commands were being executed inside the container environment.

## Container Lifecycle

Exit the container:

```bash
exit
```

List all containers:

```bash
sudo docker ps -a
```

Start the existing container:

```bash
sudo docker start ubuntu-lab
```

Check running containers:

```bash
sudo docker ps
```

Access the running container:

```bash
sudo docker exec -it ubuntu-lab bash
```

Stop the container:

```bash
sudo docker stop ubuntu-lab
```

## Data Persistence Test

Inside the container:

```bash
echo "My first Docker container" > /root/teste.txt
cat /root/teste.txt
```

The container was then stopped and started again.

```bash
sudo docker stop ubuntu-lab
sudo docker start ubuntu-lab
sudo docker exec -it ubuntu-lab bash
```

Validation:

```bash
cat /root/teste.txt
```

The file remained available after restarting the container.

## Commands Learned

```bash
docker --version
docker run
docker ps
docker ps -a
docker images
docker start
docker stop
docker exec
systemctl status docker
```

## Troubleshooting

During package installation, an incorrect package name was initially used:

```text
ca-certifications
```

The correct package name is:

```text
ca-certificates
```

After correcting the command, the installation continued normally.

## Screenshots

Evidence for this lab is stored in:

```text
screenshots/
```

## Conclusion

This lab provided the foundation for working with Docker on Linux. Docker Engine was installed successfully, the first container was executed, and the basic container lifecycle was tested using Ubuntu containers.

The lab also demonstrated the relationship between Docker images and containers, as well as how containers can be started, stopped, and accessed interactively.
