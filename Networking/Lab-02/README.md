# Networking Lab 02 - Service and Port Troubleshooting

## Overview

This lab demonstrates practical Linux network troubleshooting using a local HTTP service running on an Ubuntu virtual machine.

The objective was to diagnose service accessibility across multiple layers, including process execution, TCP listening sockets, application binding, port connectivity, firewall rules, and HTTP responses.

The lab also includes an automated Bash health-check script that generates a troubleshooting report.

## Environment

- Ubuntu Linux
- VMware Virtual Machine
- Python 3
- Bash
- TCP/IP
- HTTP
- Netcat
- UFW Firewall
- Git
- GitHub

## Lab Structure

```text
Networking/Lab-02/
├── README.md
├── data/
│   └── troubleshooting_report.txt
├── screenshots/
├── scripts/
│   └── service_check.sh
└── web/
    └── index.html
```

## Objectives

- Run a local HTTP service
- Identify listening TCP ports
- Understand service binding
- Compare `127.0.0.1` and `0.0.0.0`
- Test HTTP connectivity with `curl`
- Test TCP ports with Netcat
- Configure Linux firewall rules with UFW
- Simulate service and firewall failures
- Perform layer-by-layer troubleshooting
- Automate service health checks
- Generate a troubleshooting report

---

## 1. Local HTTP Service

A simple HTML page was created:

```html
<h1>Networking Lab 02</h1>
```

Python was used to provide a lightweight HTTP service for networking tests:

```bash
python3 -m http.server 8000
```

The service was then tested using:

```bash
curl http://127.0.0.1:8000
```

Expected response:

```html
<h1>Networking Lab 02</h1>
```

Python was used only as a simple application server. The focus of the lab was networking and troubleshooting.

---

## 2. Listening Socket Inspection

The service listening on TCP port 8000 was inspected using:

```bash
ss -tlnp | grep 8000
```

This allowed verification that:

- A process was running
- TCP port 8000 was listening
- The service binding could be identified

Example:

```text
0.0.0.0:8000
```

---

## 3. Localhost vs All Interfaces

The HTTP server was first bound specifically to localhost:

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

This restricts the service to the local machine.

```text
127.0.0.1:8000
        |
        └── Local access only
```

The server was then bound to:

```bash
python3 -m http.server 8000 --bind 0.0.0.0
```

This allows the service to listen on available IPv4 interfaces.

```text
0.0.0.0:8000
      |
      └── Available IPv4 interfaces
```

This demonstrated that a service can be running correctly while still being inaccessible remotely because of an incorrect bind address.

---

## 4. HTTP Connectivity Testing

HTTP connectivity was tested with:

```bash
curl http://127.0.0.1:8000
```

and using the VM network address:

```bash
curl http://<VM-IP>:8000
```

This validated application-layer connectivity.

The troubleshooting chain became:

```text
Process
   |
   v
Listening Socket
   |
   v
TCP Port
   |
   v
HTTP Service
   |
   v
Client
```

---

## 5. TCP Port Testing with Netcat

Netcat was used to test TCP connectivity independently from HTTP:

```bash
nc -zv 127.0.0.1 8000
```

The VM address was also tested:

```bash
nc -zv <VM-IP> 8000
```

With the service running, the connection succeeded.

Example:

```text
Connection to <VM-IP> 8000 port [tcp/*] succeeded!
```

The HTTP server was then stopped to simulate a failure.

The same Netcat test returned:

```text
Connection refused
```

This demonstrated the difference between an available and unavailable TCP service.

---

## 6. Linux Firewall with UFW

The Ubuntu firewall status was inspected using:

```bash
sudo ufw status
```

Before enabling UFW, SSH access was explicitly allowed:

```bash
sudo ufw allow OpenSSH
```

The lab HTTP service was also allowed:

```bash
sudo ufw allow 8000/tcp
```

The firewall was then enabled:

```bash
sudo ufw enable
```

Rules were inspected using:

```bash
sudo ufw status numbered
```

This introduced another layer into the troubleshooting process:

```text
Application
     |
     v
Listening Socket
     |
     v
Linux Firewall
     |
     v
Network
     |
     v
Client
```

---

## 7. Firewall Failure Simulation

The port 8000 firewall rule was temporarily removed:

```bash
sudo ufw delete allow 8000/tcp
```

The HTTP process remained running and the socket remained listening.

However, external TCP connectivity could be blocked by the firewall.

This demonstrates an important troubleshooting principle:

```text
Process running        != Service reachable

Port LISTENING         != Port externally accessible
```

After the test, access was restored:

```bash
sudo ufw allow 8000/tcp
```

---

## 8. Troubleshooting Scenario

During the lab, an additional issue occurred when the Python HTTP server was started from the wrong working directory.

The service was:

```text
Running       -> YES
Port 8000     -> LISTENING
Bind          -> Correct
HTTP response -> Unexpected content
```

The process working directory was inspected using:

```bash
readlink -f /proc/<PID>/cwd
```

The server had been started from:

```text
/home/marcos
```

instead of the lab web directory.

After starting the server from the correct directory, the expected HTML page was returned.

This demonstrated that successful network connectivity does not necessarily mean the application is serving the expected content.

---

## 9. Automated Service Health Check

A Bash script was created:

```text
scripts/service_check.sh
```

The script checks multiple service layers:

```text
Listening Socket
       |
       v
TCP Connectivity
       |
       v
HTTP Response
```

The script was made executable:

```bash
chmod +x service_check.sh
```

and executed using:

```bash
./service_check.sh
```

---

## 10. Healthy Service Test

With the HTTP server running, the automated check returned results similar to:

```text
Port 8000: LISTENING
TCP Connection: OK
HTTP Service: OK
HTTP Status: 200
```

This indicates that the service successfully passed socket, TCP, and HTTP checks.

---

## 11. Failure Simulation

The HTTP server was stopped and the automated check was executed again.

The expected result was:

```text
Port 8000: NOT LISTENING
TCP Connection: FAILED
HTTP Service: FAILED
HTTP Status: 000
```

`000` is not an HTTP response status. In this context, it indicates that `curl` did not receive an HTTP response from the target service.

---

## 12. Troubleshooting Report

The automated results are stored in:

```text
data/troubleshooting_report.txt
```

This provides a reusable service troubleshooting report containing:

- Target host
- Target port
- Target URL
- Listening socket status
- TCP connectivity status
- HTTP service status
- HTTP response code

---

## Troubleshooting Methodology

The lab established the following workflow:

```text
Application unavailable
        |
        v
Is the process running?
        |
        v
Is the port LISTENING?
        |
        v
Is the bind address correct?
        |
        v
Can TCP connect to the port?
        |
        v
Does the firewall allow traffic?
        |
        v
Does HTTP respond?
        |
        v
Is the expected content returned?
```

This approach helps isolate problems instead of assuming that every connectivity issue is caused by the network.

---

## Key Commands

```bash
python3 -m http.server
ss -tlnp
curl
nc -zv
hostname -I
sudo ufw status
sudo ufw allow
sudo ufw delete
readlink
chmod
```

---

## Key Concepts

- TCP ports
- Listening sockets
- Service binding
- Loopback interface
- Local vs remote connectivity
- Application-layer testing
- Linux firewall rules
- Connection refused
- HTTP status codes
- Layer-by-layer troubleshooting
- Service health checks

---

## Result

A local HTTP service was deployed and tested across multiple networking layers.

Service binding, TCP connectivity, firewall behavior, application responses, and simulated failures were successfully investigated.

A Bash health-check script was also created to automate socket, TCP, and HTTP diagnostics and generate a reusable troubleshooting report.

This lab provides practical experience with Linux service troubleshooting applicable to Cloud, Infrastructure, DevOps, and System Administration environments.
