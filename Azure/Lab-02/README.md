# Azure Lab 02 - Virtual Network, Subnet and Network Security Group

## Scenario

This lab focuses on building and securing a basic network architecture in Microsoft Azure using Azure CLI from an Ubuntu Linux environment.

The objective was to create a Virtual Network, configure a subnet, associate a Network Security Group (NSG), create inbound security rules and validate the complete network configuration using command-line tools.

## Objectives

- Create an Azure Virtual Network using Azure CLI
- Configure an IP address space
- Create a subnet
- Create a Network Security Group
- Associate an NSG with a subnet
- Create inbound security rules
- Understand HTTP and SSH network access
- Understand NSG rule priorities
- Validate Azure networking resources using CLI
- Practice basic cloud network security

## Environment

- Ubuntu Linux
- Microsoft Azure
- Azure CLI
- Azure Resource Group
- Azure Virtual Network
- Network Security Group
- Git
- GitHub

## Architecture

Azure Subscription

↓

Resource Group: rg-cloudlab-dev

↓

Virtual Network: vnet-cloudlab
10.10.0.0/16

↓

Subnet: subnet-web
10.10.1.0/24

↓

Network Security Group: nsg-web

↓

Inbound Security Rules

- HTTP TCP/80
- SSH TCP/22 with restricted source

## Virtual Network

A Virtual Network (VNet) provides a private network environment inside Microsoft Azure.

The following VNet was created:

Name:

`vnet-cloudlab`

Address space:

`10.10.0.0/16`

Command:

`az network vnet create --resource-group rg-cloudlab-dev --name vnet-cloudlab --address-prefixes 10.10.0.0/16 --subnet-name subnet-web --subnet-prefixes 10.10.1.0/24`

## Subnet

A subnet divides the VNet address space into smaller network segments.

Subnet:

`subnet-web`

Address range:

`10.10.1.0/24`

The subnet was created inside the `vnet-cloudlab` Virtual Network.

## Network Security Group

A Network Security Group (NSG) controls inbound and outbound network traffic using security rules.

NSG created:

`nsg-web`

Command:

`az network nsg create --resource-group rg-cloudlab-dev --name nsg-web --location brazilsouth`

## NSG and Subnet Association

The NSG was associated with the `subnet-web` subnet.

Command:

`az network vnet subnet update --resource-group rg-cloudlab-dev --vnet-name vnet-cloudlab --name subnet-web --network-security-group nsg-web`

This allows the NSG rules to control traffic associated with the subnet.

## HTTP Security Rule

An inbound rule was created to allow HTTP traffic.

Rule:

`Allow-HTTP`

Configuration:

- Direction: Inbound
- Protocol: TCP
- Destination Port: 80
- Source: Internet
- Access: Allow
- Priority: 100

Command:

`az network nsg rule create --resource-group rg-cloudlab-dev --nsg-name nsg-web --name Allow-HTTP --priority 100 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes Internet --source-port-ranges "*" --destination-address-prefixes "*" --destination-port-ranges 80`

## SSH Security Rule

A second inbound rule was created to demonstrate restricted administrative access using SSH.

Rule:

`Allow-SSH-Admin`

Configuration:

- Direction: Inbound
- Protocol: TCP
- Destination Port: 22
- Source: Restricted example IP
- Access: Allow
- Priority: 110

Command:

`az network nsg rule create --resource-group rg-cloudlab-dev --nsg-name nsg-web --name Allow-SSH-Admin --priority 110 --direction Inbound --access Allow --protocol Tcp --source-address-prefixes 203.0.113.10/32 --source-port-ranges "*" --destination-address-prefixes "*" --destination-port-ranges 22`

The IP address `203.0.113.10/32` was used only as a documentation/example address for this lab.

## HTTP vs SSH

HTTP:

`TCP/80`

Used for standard web traffic.

SSH:

`TCP/22`

Used for remote administration of Linux systems.

SSH access should normally be restricted to trusted sources instead of being exposed to the entire Internet.

## NSG Rule Priority

NSG rules use priority numbers to determine the order in which rules are evaluated.

Lower numbers represent higher priority.

Example:

`100 - Allow-HTTP`

`110 - Allow-SSH-Admin`

## Validation Commands

### Show Virtual Network

`az network vnet show --resource-group rg-cloudlab-dev --name vnet-cloudlab --output table`

### Show Subnet

`az network vnet subnet show --resource-group rg-cloudlab-dev --vnet-name vnet-cloudlab --name subnet-web --output table`

### Show Network Security Group

`az network nsg show --resource-group rg-cloudlab-dev --name nsg-web --output table`

### List NSG Rules

`az network nsg rule list --resource-group rg-cloudlab-dev --nsg-name nsg-web --output table`

## Network Flow

Internet

↓

Network Security Group

↓

Inbound Security Rules

↓

Subnet

↓

Future Azure Resources

Examples:

- Virtual Machines
- Web Servers
- Application Servers

## Security Concepts

This lab demonstrated several important cloud networking principles:

- Network segmentation using subnets
- Traffic filtering using NSGs
- Inbound traffic control
- Port-based security rules
- Rule priorities
- Restricted administrative access
- Principle of reducing unnecessary Internet exposure

## Result

A basic Azure network architecture was successfully created and configured entirely through Azure CLI.

The environment contains:

- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- HTTP inbound rule
- Restricted SSH inbound rule

The complete architecture was validated from the Linux terminal using Azure CLI commands.

## Key Learning

Azure Virtual Networks provide private network environments for cloud resources.

Subnets allow the network to be segmented into smaller address ranges.

Network Security Groups provide traffic filtering using inbound and outbound security rules.

Azure CLI allows these networking components to be created, configured and validated directly from a Linux terminal.

This lab provides a foundation for deploying Virtual Machines and other Azure services into a controlled network environment.
