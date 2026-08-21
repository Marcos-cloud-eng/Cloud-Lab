# Networking Lab 01 - Linux Network Fundamentals

## Overview

This lab demonstrates fundamental Linux networking and troubleshooting techniques in an Ubuntu virtual machine.

The objective was to inspect network configuration, validate connectivity, troubleshoot DNS, analyze listening ports, test HTTP/HTTPS services, trace network paths, and automate network diagnostics using Bash.

## Environment

- Ubuntu Linux
- VMware Virtual Machine
- Bash
- TCP/IP
- DNS
- HTTP/HTTPS
- Git
- GitHub

## Lab Structure

```text
Networking/Lab-01/
├── README.md
├── data/
│   └── network_report.txt
├── screenshots/
└── scripts/
    └── network_check.sh
```

## Objectives

- Identify Linux network interfaces
- Identify IP addresses
- Inspect the default gateway
- Understand the routing table
- Test local and external connectivity
- Test DNS resolution
- Query DNS records
- Inspect listening TCP and UDP ports
- Test HTTP/HTTPS connectivity
- Trace network paths
- Automate network diagnostics
- Generate a network report

---

## 1. Host and IP Information

The hostname was identified using:

```bash
hostname
```

IP addresses assigned to the machine were displayed with:

```bash
hostname -I
```

Detailed network interface information was inspected using:

```bash
ip a
```

This command provides information about network interfaces, IPv4/IPv6 addresses, interface state, and network prefixes.

### Key Concepts

```text
Interface
   |
   +-- IP Address
   +-- Network Prefix
   +-- Interface State
```

---

## 2. Routing and Default Gateway

The Linux routing table was inspected using:

```bash
ip route
```

The default route identifies the gateway used to reach destinations outside the local network.

Example:

```text
default via <gateway-ip> dev <interface>
```

Conceptually:

```text
Linux VM
   |
   v
Network Interface
   |
   v
Default Gateway
   |
   v
External Networks
```

---

## 3. Connectivity Testing

Connectivity was tested using `ping`.

Local TCP/IP stack:

```bash
ping -c 4 127.0.0.1
```

External IP connectivity:

```bash
ping -c 4 8.8.8.8
```

DNS-based connectivity:

```bash
ping -c 4 google.com
```

The tests validated connectivity and allowed packet loss and latency to be observed.

Example successful result:

```text
4 packets transmitted
4 received
0% packet loss
```

### Troubleshooting Logic

A useful troubleshooting sequence is:

```text
Localhost
    |
    v
Local Network
    |
    v
Gateway
    |
    v
Internet
    |
    v
DNS
    |
    v
Application
```

Testing progressively helps isolate where a network problem is occurring.

---

## 4. DNS Resolution

DNS resolution was tested using:

```bash
nslookup google.com
```

and:

```bash
dig google.com
```

A shorter DNS query can be performed using:

```bash
dig +short google.com
```

Different DNS record types were also inspected:

```bash
dig google.com A
dig google.com AAAA
dig google.com MX
```

### DNS Record Types

```text
A       -> IPv4 address
AAAA    -> IPv6 address
MX      -> Mail server
```

DNS allows human-readable domain names to be translated into IP addresses.

---

## 5. Listening Ports and Sockets

Listening TCP and UDP sockets were inspected using:

```bash
ss -tuln
```

Processes associated with listening ports were inspected using:

```bash
sudo ss -tulpn
```

Options used:

```text
-t  TCP
-u  UDP
-l  Listening
-n  Numeric addresses and ports
-p  Process information
```

A service listening on:

```text
0.0.0.0:<port>
```

is listening on available IPv4 interfaces.

A service listening on:

```text
127.0.0.1:<port>
```

is restricted to the local machine.

This distinction is important when troubleshooting application accessibility.

---

## 6. HTTP and HTTPS Testing

Application-layer connectivity was tested using `curl`.

Retrieve a webpage:

```bash
curl https://example.com
```

Retrieve HTTP headers:

```bash
curl -I https://example.com
```

Verbose connection information:

```bash
curl -v https://example.com
```

Retrieve only the HTTP status code:

```bash
curl -s -o /dev/null -w "%{http_code}\n" https://example.com
```

A successful request returned:

```text
200
```

### Ping vs Curl

`ping` tests ICMP reachability.

`curl` can test whether an HTTP/HTTPS service is actually responding.

Therefore:

```text
Ping failure != Web service failure
```

A firewall may block ICMP while allowing HTTPS traffic on TCP port 443.

---

## 7. Network Path Analysis

The route between the VM and an external destination was inspected using:

```bash
traceroute google.com
```

and:

```bash
traceroute 8.8.8.8
```

Each intermediate network device is represented as a hop.

Conceptually:

```text
VM
 |
 v
Gateway
 |
 v
Router / ISP
 |
 v
Intermediate Hops
 |
 v
Destination
```

A `* * *` response does not necessarily indicate a broken connection because intermediate devices may choose not to respond to traceroute probes.

---

## 8. Automated Network Check

A Bash script was created:

```text
scripts/network_check.sh
```

The script automates several network diagnostics and generates a consolidated report.

It collects:

- Hostname
- IP addresses
- Network interfaces
- Routing table
- Internet connectivity status
- DNS resolution status
- HTTP status
- Listening ports

The script was made executable using:

```bash
chmod +x network_check.sh
```

and executed with:

```bash
./network_check.sh
```

---

## 9. Network Report

The automated diagnostic results are stored in:

```text
data/network_report.txt
```

The report contains information similar to:

```text
LINUX NETWORK REPORT

Hostname: ...
IP Address: ...

NETWORK INTERFACES
...

ROUTING TABLE
...

INTERNET CONNECTIVITY
Internet Connectivity: OK

DNS RESOLUTION
DNS Resolution: OK

HTTP/HTTPS CHECK
HTTP Status: 200

LISTENING PORTS
...
```

This provides a reusable method for performing a basic Linux network assessment.

---

## Bash Concepts Used

Output redirection:

```bash
>
```

creates or overwrites a file.

```bash
>>
```

appends output to an existing file.

The script also uses:

```bash
> /dev/null 2>&1
```

to discard standard output and standard error when only the command result is required.

Conditional checks were implemented using:

```bash
if
then
else
fi
```

---

## Network Troubleshooting Workflow

The lab established the following troubleshooting methodology:

```text
1. Check interface
        |
        v
2. Check IP address
        |
        v
3. Check routing / gateway
        |
        v
4. Test IP connectivity
        |
        v
5. Test DNS
        |
        v
6. Inspect ports
        |
        v
7. Test application protocol
        |
        v
8. Trace network path
```

---

## Key Commands

```bash
hostname
hostname -I
ip a
ip route
ping
nslookup
dig
ss
curl
traceroute
```

---

## Result

A complete basic network assessment was successfully performed on an Ubuntu Linux virtual machine.

The lab validated:

- Network interface configuration
- IP addressing
- Routing
- Internet connectivity
- DNS resolution
- TCP/UDP listening sockets
- HTTP/HTTPS connectivity
- Network path visibility

The manual troubleshooting process was then automated using a Bash script that generates a reusable network diagnostic report.

This lab provides a practical foundation for troubleshooting networking in Linux, Cloud, and Infrastructure environments.
