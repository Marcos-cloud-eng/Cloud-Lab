# AWS Lab 02 - VPC, EC2, Security Groups and Nginx

## Scenario

This lab focuses on deploying a complete basic web infrastructure in AWS using AWS CLI and Linux.

The environment was built from the networking layer up to a publicly accessible Nginx web server running on Amazon EC2.

## Objectives

- Create a custom AWS VPC
- Create a public subnet
- Configure an Internet Gateway
- Create and associate a Route Table
- Configure Internet routing
- Create a Security Group
- Restrict SSH access
- Launch an Amazon Linux EC2 instance
- Connect to EC2 using SSH
- Install and manage Nginx
- Publish a web page through the Internet
- Practice AWS CLI troubleshooting
- Clean up AWS resources after the lab

## Environment

- Ubuntu Linux
- AWS CLI v2
- Amazon VPC
- Amazon EC2
- Amazon Linux
- Security Groups
- Internet Gateway
- Route Tables
- Nginx
- SSH
- Git
- GitHub

Region:

`sa-east-1`

## Architecture

Internet

↓

Internet Gateway

↓

Route Table

`0.0.0.0/0`

↓

VPC

`10.10.0.0/16`

↓

Public Subnet

`10.10.1.0/24`

↓

Security Group

- SSH TCP/22 - restricted source
- HTTP TCP/80

↓

Amazon EC2

↓

Amazon Linux

↓

Nginx

↓

Public Web Page

## VPC

A custom VPC was created:

`cloudlab-vpc`

CIDR:

`10.10.0.0/16`

The VPC ID was stored in a Bash variable:

`VPC_ID`

This demonstrated how AWS CLI output can be reused inside shell scripts and commands.

## Public Subnet

A public subnet was created inside the VPC.

Subnet:

`cloudlab-public-subnet`

CIDR:

`10.10.1.0/24`

The subnet ID was stored as:

`SUBNET_ID`

## Internet Gateway

An Internet Gateway was created:

`cloudlab-igw`

The gateway was attached to the Cloud Lab VPC.

This provides the VPC with a path to the public Internet when combined with a Route Table.

## Route Table

A custom Route Table was created:

`cloudlab-public-rt`

A default IPv4 route was configured:

`0.0.0.0/0`

Target:

Internet Gateway

The Route Table was then associated with the public subnet.

## Security Group

A custom Security Group was created:

`cloudlab-sg`

The Security Group controls network traffic reaching the EC2 instance.

SSH:

`TCP/22`

SSH access was restricted to a specific public IP address using `/32`.

HTTP:

`TCP/80`

HTTP access was enabled to test the Nginx web server.

## Key Pair

An EC2 Key Pair was created:

`cloudlab-key`

The private key was saved locally as:

`cloudlab-key.pem`

File permissions were restricted using:

`chmod 400 cloudlab-key.pem`

The private key must never be committed to GitHub.

## Amazon EC2

An Amazon Linux EC2 instance was launched using AWS CLI.

Instance name:

`cloudlab-ec2`

The EC2 instance was deployed inside:

- cloudlab-vpc
- cloudlab-public-subnet
- cloudlab-sg

A public IPv4 address was assigned to allow remote access.

## SSH Access

The EC2 instance was accessed remotely using:

`ssh -i cloudlab-key.pem ec2-user@PUBLIC_IP`

This demonstrated remote Linux administration through AWS networking and Security Groups.

## Linux Administration

Inside the EC2 instance, Linux commands were used to inspect and manage the server.

Examples:

`whoami`

`hostname`

`cat /etc/os-release`

`free -h`

`df -h`

`ps aux`

## Nginx

Nginx was installed on the Amazon Linux EC2 instance.

Installation:

`sudo dnf install nginx -y`

Start service:

`sudo systemctl start nginx`

Enable automatic startup:

`sudo systemctl enable nginx`

Validate service:

`sudo systemctl status nginx`

The Nginx document root was identified using:

`sudo nginx -T 2>/dev/null | grep "root "`

Document root:

`/usr/share/nginx/html`

## Custom Web Page

The default Nginx page was replaced with a custom Cloud Lab page.

The final page displayed:

`AWS Cloud Lab - Lab 02`

`EC2 + VPC + Nginx`

The page was successfully accessed using the EC2 public IP address.

## Network Flow

Client Browser

↓

Internet

↓

Internet Gateway

↓

Route Table

↓

Public Subnet

↓

Security Group TCP/80

↓

EC2

↓

Nginx

↓

HTML Page

## Troubleshooting

### Empty Bash Variables

Several AWS resource IDs were stored in Bash variables such as:

`VPC_ID`

`SUBNET_ID`

`IGW_ID`

`RT_ID`

`SG_ID`

`INSTANCE_ID`

`PUBLIC_IP`

Some variables were lost when the shell session changed.

The resources still existed in AWS.

The IDs were recovered using AWS CLI describe commands and resource tags.

### Route Table ID Missing

The AWS CLI returned:

`argument --route-table-id: expected one argument`

Cause:

`RT_ID` was empty.

The Route Table ID was recovered using AWS CLI.

### Internet Gateway Routing Issue

AWS returned an error indicating that the Route Table and Internet Gateway belonged to different networks.

Investigation showed the importance of validating the Internet Gateway attachment and the VPC associated with each networking resource.

### Subnet ID Missing

AWS returned:

`argument --subnet-id: expected one argument`

Cause:

`SUBNET_ID` was empty.

The Subnet ID was recovered by filtering subnets using the VPC ID and resource tag.

### Security Group Validation

A default Security Group from another VPC was initially displayed.

The correct Security Group was located by filtering using:

- VPC ID
- Group name

This reinforced the importance of validating resource ownership before using IDs in AWS commands.

### AWS Session Expiration

AWS CLI temporary credentials expired during the lab.

The session was restored using:

`aws login`

and validated with:

`aws sts get-caller-identity`

### Local Host vs Remote EC2

An attempt was made to modify the Nginx HTML directory from the local Ubuntu environment.

The error:

`No such file or directory`

was resolved by checking the shell prompt and reconnecting to the EC2 instance through SSH.

This demonstrated the importance of understanding whether commands are running locally or remotely.

## Key Concepts

### EC2

Amazon EC2 provides virtual servers in AWS.

### VPC

Amazon VPC provides an isolated virtual network for AWS resources.

### Subnet

A subnet divides the VPC network into smaller address ranges.

### Internet Gateway

Provides a path between a VPC and the public Internet.

### Route Table

Determines where network traffic is directed.

### Security Group

Acts as a stateful firewall controlling traffic to AWS resources.

### Nginx

Nginx is a web server and reverse proxy used to deliver HTTP content and applications.

## Result

A complete basic AWS web infrastructure was successfully deployed using AWS CLI.

The environment included:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2
- SSH access
- Amazon Linux
- Nginx
- Public web page

The lab also included multiple real troubleshooting scenarios involving AWS networking, Bash variables, authentication and Linux administration.

## Key Learning

This lab demonstrated how AWS networking components work together to provide secure Internet access to an EC2 workload.

It also demonstrated that Cloud Administration requires more than resource creation: engineers must understand networking, Linux, authentication, security, troubleshooting and resource lifecycle management.
