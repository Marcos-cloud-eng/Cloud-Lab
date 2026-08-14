# Docker Lab 02 - Nginx, Port Mapping, Persistence and Networking

## Scenario

This lab focuses on practical Docker container management using Nginx as a web server.

The objective was to deploy an Nginx container, expose the application through port mapping, access the container filesystem, modify web content, inspect logs, implement persistent storage and configure communication between containers using a custom Docker network.

## Objectives

- Run containers in detached mode
- Configure container names
- Understand Docker port mapping
- Deploy an Nginx web server
- Access a running container with docker exec
- Inspect the container filesystem
- Modify content served by Nginx
- Inspect container logs
- Understand ephemeral container storage
- Implement persistent content using a bind mount
- Create a custom Docker network
- Connect containers to a network
- Test container-to-container communication
- Practice Docker troubleshooting

## Environment

- Ubuntu Linux
- Docker Engine
- Nginx
- curl
- Git
- GitHub

---

## Docker Images

Available Docker images were inspected using:

`docker images`

Images used during the labs included:

- nginx
- ubuntu
- hello-world
- curlimages/curl

Minikube/Kubernetes images were also present in the Docker environment.

---

## Running Nginx

An Nginx container was created using:

`docker run -d --name nginx-lab02 -p 8080:80 nginx`

Options:

- `-d` - runs the container in detached mode
- `--name` - assigns a custom name to the container
- `-p 8080:80` - maps host port 8080 to container port 80

Port mapping:

Host TCP/8080

↓

Docker

↓

Container TCP/80

↓

Nginx

The running container was verified using:

`docker ps`

The web server was tested using:

`curl http://localhost:8080`

It was also accessed through a web browser using:

`http://localhost:8080`

---

## Accessing the Container

The running Nginx container was accessed using:

`docker exec -it nginx-lab02 /bin/bash`

Inside the container, several commands were used:

`whoami`

`hostname`

`pwd`

`ls`

The Nginx web directory was located at:

`/usr/share/nginx/html`

The directory was inspected using:

`ls -la`

The default page was inspected using:

`cat index.html`

---

## Custom Nginx Page

The original Nginx page was backed up:

`cp index.html index.html.bkp`

The default page was replaced with custom Cloud Lab content.

Example:

`echo "<h1>Marcos Cloud Lab - Docker LAB 02</h1><p>Nginx running inside Docker.</p>" > index.html`

The result was immediately available through:

`http://localhost:8080`

This demonstrated how Nginx serves files stored inside the container through HTTP.

---

## Container Logs

Nginx logs were inspected using:

`docker logs nginx-lab02`

Real-time log monitoring was performed using:

`docker logs -f nginx-lab02`

Refreshing the web page generated new HTTP requests that appeared in the container logs.

Real-time monitoring was stopped using:

`Ctrl + C`

This stops log monitoring without stopping the container.

---

## Container Storage

The Nginx container was removed using:

`docker rm -f nginx-lab02`

After recreating the container, the custom HTML page stored inside the previous container was lost.

This demonstrated that data written only to a container's writable layer should not be treated as persistent storage.

---

## Persistent Content with Bind Mount

A directory was created on the Ubuntu host:

`mkdir -p ~/Cloud-Lab/Docker/Lab-02/site`

A persistent HTML file was created:

`echo "<h1>Marcos Cloud Lab - Persistent Docker Site</h1><p>This content survives container recreation.</p>" > ~/Cloud-Lab/Docker/Lab-02/site/index.html`

The Nginx container was recreated using a bind mount:

`docker run -d --name nginx-lab02 -p 8080:80 -v ~/Cloud-Lab/Docker/Lab-02/site:/usr/share/nginx/html:ro nginx`

Bind mount structure:

Ubuntu Host

`~/Cloud-Lab/Docker/Lab-02/site`

↓

Docker Bind Mount

↓

Nginx Container

`/usr/share/nginx/html`

The `:ro` option mounts the directory as read-only inside the container.

After removing and recreating the container with the same bind mount, the custom web content remained available.

This demonstrated persistent application content outside the container lifecycle.

---

## Docker Networking

A custom Docker network was created:

`docker network create cloudlab-network`

Available networks were inspected using:

`docker network ls`

The Nginx container was connected to the custom network:

`docker network connect cloudlab-network nginx-lab02`

The network configuration was inspected using:

`docker network inspect cloudlab-network`

---

## Container-to-Container Communication

A temporary curl container was launched inside the same Docker network:

`docker run --rm --network cloudlab-network curlimages/curl http://nginx-lab02`

The temporary container successfully accessed the Nginx container using:

`http://nginx-lab02`

instead of an IP address.

Network flow:

curl container

↓

cloudlab-network

↓

nginx-lab02

↓

TCP/80

↓

Nginx

This demonstrated Docker's internal name resolution between containers connected to the same custom network.

---

## Troubleshooting

### Container Name Conflict

While attempting to create the Nginx container, Docker returned:

`Conflict. The container name "/nginx-lab02" is already in use.`

The existing containers were checked using:

`docker ps -a`

This demonstrated that Docker container names must be unique.

An existing container can be started using:

`docker start nginx-lab02`

or removed using:

`docker rm -f nginx-lab02`

before recreating it.

### No Such Container

Another troubleshooting scenario returned:

`No such container: nginx-lab02`

The available containers were checked using:

`docker ps -a`

This reinforced the importance of verifying container state and names before running management commands.

---

## Validation Commands

Running containers:

`docker ps`

All containers:

`docker ps -a`

Docker images:

`docker images`

Docker networks:

`docker network ls`

Network configuration:

`docker network inspect cloudlab-network`

Nginx HTTP test:

`curl http://localhost:8080`

Container logs:

`docker logs nginx-lab02`

---

## Architecture

Browser / curl

↓

Ubuntu Host TCP/8080

↓

Docker Port Mapping

↓

nginx-lab02 TCP/80

↓

Nginx

↓

Persistent HTML Content

↑

Bind Mount

↑

Ubuntu Host Directory

`~/Cloud-Lab/Docker/Lab-02/site`

Container networking:

curl container

↓

cloudlab-network

↓

nginx-lab02

↓

Nginx

---

## Key Concepts

### Image

A template used to create containers.

### Container

A running instance created from an image.

### Port Mapping

Maps a host port to a port inside a container.

Example:

`8080:80`

means:

`HOST:CONTAINER`

### docker exec

Runs a command inside an existing running container.

### Logs

Provide information about application and container activity.

### Bind Mount

Maps a host directory into a container, allowing data to exist independently from the container lifecycle.

### Docker Network

Provides networking and communication between containers.

---

## Result

A complete Nginx environment was successfully deployed and managed using Docker.

The lab demonstrated:

- Container creation
- Port mapping
- Nginx web serving
- Container access
- Filesystem manipulation
- HTTP testing
- Log monitoring
- Container recreation
- Persistent content
- Bind mounts
- Custom Docker networks
- Container-to-container communication
- Troubleshooting

## Key Learning

Containers are disposable, but application data often must persist independently from the container lifecycle.

Docker provides port mapping for external access, bind mounts and volumes for persistent data, and networks for communication between containers.

Understanding these concepts provides an important foundation for containerized applications and Kubernetes.
