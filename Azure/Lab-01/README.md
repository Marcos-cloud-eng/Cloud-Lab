# Azure Lab 01 - Azure CLI and Resource Group Management

## Scenario

This lab introduces practical Microsoft Azure administration using the Azure CLI from an Ubuntu Linux environment.

The objective was to configure Azure CLI access, authenticate with Microsoft Azure, verify the active subscription and create and manage a Resource Group using command-line tools.

## Objectives

- Install and configure Azure CLI on Ubuntu
- Authenticate with Microsoft Azure
- Understand Azure subscriptions
- Create a Resource Group using Azure CLI
- Apply tags for resource organization and governance
- Query Azure resources from the Linux terminal
- Practice troubleshooting with Azure CLI

## Environment

- Ubuntu Linux
- Microsoft Azure
- Azure CLI
- Git
- GitHub

## Azure CLI

Azure CLI provides command-line access to Microsoft Azure.

Instead of managing resources only through the Azure Portal, Azure CLI allows administrators and engineers to create, query, modify and delete Azure resources using commands.

Main command:

`az`

## Authentication

Authentication was performed using Azure CLI.

Standard authentication:

`az login`

Device Code authentication was also tested:

`az login --use-device-code`

The Device Code method allowed authentication through a web browser outside the Linux VM.

## Subscription

The active Azure subscription can be verified with:

`az account show --output table`

Available subscriptions can be listed with:

`az account list --output table`

Azure resources are created inside an Azure subscription.

## Resource Group

A Resource Group was created to organize the resources used by the Cloud Lab.

Resource Group:

`rg-cloudlab-dev`

Region:

`Brazil South`

Command:

`az group create --name rg-cloudlab-dev --location brazilsouth --tags Environment=Lab Project=Cloud-Lab ManagedBy=Marcos`

## Tags

The Resource Group was created with the following tags:

- Environment = Lab
- Project = Cloud-Lab
- ManagedBy = Marcos

Tags help organize, identify and manage Azure resources.

## Resource Validation

The Resource Group can be queried with:

`az group show --name rg-cloudlab-dev --output table`

All available Resource Groups can be listed with:

`az group list --output table`

## Troubleshooting

### Azure CLI - Command Not Found

Initial issue:

`az: command not found`

Azure CLI was installed and configured in the Ubuntu environment before continuing with the lab.

After installation, the CLI was validated using:

`az version`

### Authentication and Subscription

During the initial authentication attempts, Azure CLI returned:

`No subscriptions found`

Authentication was tested again using Device Code authentication:

`az login --use-device-code`

This troubleshooting helped distinguish Azure authentication from Azure subscription access.

### ResourceGroupNotFound

When attempting to query the Resource Group before creating it, Azure returned:

`ResourceGroupNotFound`

Message:

`Resource group 'rg-cloudlab-dev' could not be found.`

The command used was:

`az group show --name rg-cloudlab-dev --output table`

The issue occurred because `az group show` queries an existing Resource Group but the Resource Group had not yet been created.

The Resource Group was then created using:

`az group create --name rg-cloudlab-dev --location brazilsouth --tags Environment=Lab Project=Cloud-Lab ManagedBy=Marcos`

After creation, the Resource Group could be successfully queried through Azure CLI.

## Workflow

Ubuntu Linux

↓

Azure CLI

↓

Azure Authentication

↓

Azure Subscription

↓

Resource Group

↓

Tags / Governance

↓

Resource Validation

## Result

The Azure CLI environment was successfully configured and connected to Microsoft Azure.

A Resource Group was created in the Brazil South region directly from the Linux terminal and organized using Azure tags.

The lab also included troubleshooting of CLI installation, authentication, subscription access and Resource Group management.

## Key Learning

Azure CLI allows cloud infrastructure to be managed directly from the command line.

This provides a foundation for automation, scripting and Infrastructure as Code workflows.

The lab also demonstrated an important troubleshooting principle: authentication, subscription access and resource existence are separate layers that must be validated independently.
