# AWS Lab 01 - AWS CLI, IAM and Amazon S3

## Scenario

This lab introduces practical AWS administration using the AWS Command Line Interface (AWS CLI) from an Ubuntu Linux environment.

The objective was to configure secure access to AWS, validate the authenticated identity, explore IAM concepts and manage Amazon S3 resources directly from the Linux terminal.

## Objectives

- Install AWS CLI v2 on Ubuntu
- Configure secure AWS account access
- Enable MFA for the AWS root account
- Authenticate AWS CLI
- Validate the authenticated identity using AWS STS
- Understand IAM fundamentals
- Inspect IAM account information
- Configure the AWS region
- Create an Amazon S3 bucket
- Upload an object to S3
- List S3 buckets and objects
- Download an object from S3
- Validate downloaded data
- Remove AWS resources after the lab
- Practice AWS administration through Linux CLI

---

## Environment

- Ubuntu Linux
- AWS CLI v2
- AWS Account
- AWS IAM
- AWS STS
- Amazon S3
- Git
- GitHub

AWS Region used:

`sa-east-1`

South America (São Paulo)

---

## AWS CLI Installation

Initially, AWS CLI was not available in the Linux environment.

Validation:

`aws --version`

The AWS CLI v2 official installer was downloaded and installed.

After installation, the CLI was validated using:

`aws --version`

The environment successfully detected AWS CLI v2.

---

## Account Security

Multi-Factor Authentication (MFA) was configured for the AWS root account.

This provides an additional authentication factor beyond the account password.

The root account should be reserved for tasks that specifically require root credentials and should not be used for routine administration.

---

## AWS CLI Authentication

AWS CLI authentication was performed using:

`aws login`

This allowed the local AWS CLI environment to authenticate using temporary credentials associated with the AWS session instead of creating permanent root access keys.

---

## AWS STS

The authenticated identity was validated using AWS Security Token Service (STS):

`aws sts get-caller-identity`

This command returns information about the identity currently being used by AWS CLI.

The output includes:

- User ID
- AWS Account ID
- ARN

Sensitive account information was excluded from public GitHub screenshots.

---

## AWS Region

The configured AWS region was checked using:

`aws configure get region`

The lab used:

`sa-east-1`

If required, the region can be configured using:

`aws configure set region sa-east-1`

---

## IAM - Identity and Access Management

AWS IAM was explored through the AWS CLI.

IAM controls identities and permissions within AWS.

Core IAM concepts include:

- Users
- Groups
- Roles
- Policies

Account information was inspected using:

`aws iam get-account-summary`

Existing IAM users were inspected using:

`aws iam list-users`

The new AWS account initially contained no IAM users.

IAM roles can be inspected using:

`aws iam list-roles`

The account summary also confirmed that MFA was enabled.

---

## IAM Concepts

### User

Represents an IAM identity that can receive permissions.

### Group

Allows multiple IAM users to be organized and managed together.

### Role

An AWS identity with permissions that can be assumed temporarily by users, applications or AWS services.

### Policy

Defines which AWS actions are allowed or denied for an identity or resource.

IAM can therefore be summarized as:

Identity

↓

IAM Policies / Permissions

↓

AWS Resources

---

## Amazon S3

Amazon Simple Storage Service (Amazon S3) was used to practice object storage administration.

S3 stores data as objects inside buckets.

Basic structure:

S3

↓

Bucket

↓

Object

---

## Creating an S3 Bucket

An S3 bucket was created using AWS CLI:

`aws s3api create-bucket --bucket marcos-cloud-lab-s3-2026 --region sa-east-1 --create-bucket-configuration LocationConstraint=sa-east-1`

Buckets were listed using:

`aws s3 ls`

S3 bucket names must be globally unique.

---

## Creating a Test File

A local test file was created in Ubuntu:

`echo "AWS Cloud Lab - S3 test file" > cloudlab.txt`

The file was validated using:

`cat cloudlab.txt`

---

## Uploading an Object to S3

The local file was uploaded to the S3 bucket:

`aws s3 cp cloudlab.txt s3://marcos-cloud-lab-s3-2026/`

The objects stored inside the bucket were listed using:

`aws s3 ls s3://marcos-cloud-lab-s3-2026/`

Architecture:

Ubuntu

↓

AWS CLI

↓

Amazon S3

↓

Bucket

↓

cloudlab.txt

---

## Downloading an Object

A directory was created for the download test:

`mkdir download-test`

The S3 object was downloaded:

`aws s3 cp s3://marcos-cloud-lab-s3-2026/cloudlab.txt download-test/cloudlab-downloaded.txt`

The downloaded file was inspected using:

`cat download-test/cloudlab-downloaded.txt`

---

## File Validation

The original file and downloaded file were compared using:

`diff cloudlab.txt download-test/cloudlab-downloaded.txt`

No output from `diff` indicated that both files contained identical data.

This validated the upload and download process.

---

## S3 Terminology

### Bucket

A logical container used to store objects in Amazon S3.

### Object

The actual data stored inside an S3 bucket.

### Key

The identifier or path used to locate an object inside a bucket.

Example:

`s3://marcos-cloud-lab-s3-2026/cloudlab.txt`

Where:

- `marcos-cloud-lab-s3-2026` = bucket
- `cloudlab.txt` = object key

---

## AWS S3 CLI vs S3 API

High-level S3 commands:

`aws s3`

Examples:

`aws s3 ls`

`aws s3 cp`

`aws s3 rm`

These commands provide convenient operations for working with S3 data.

Lower-level S3 API commands:

`aws s3api`

Example:

`aws s3api create-bucket`

These commands provide more direct access to S3 API operations and configuration.

---

## Resource Cleanup

The S3 object was removed using:

`aws s3 rm s3://marcos-cloud-lab-s3-2026/cloudlab.txt`

The empty bucket was then removed:

`aws s3api delete-bucket --bucket marcos-cloud-lab-s3-2026 --region sa-east-1`

Finally, existing buckets were checked:

`aws s3 ls`

This confirmed that the lab resources had been successfully removed.

---

## Resource Lifecycle

The complete lifecycle practiced in this lab was:

Create

↓

Configure

↓

Validate

↓

Upload

↓

List

↓

Download

↓

Verify

↓

Delete Object

↓

Delete Bucket

↓

Validate Cleanup

---

## Security Practices

Security practices applied during this lab included:

- MFA enabled for the AWS root account
- No permanent root access keys created
- Temporary AWS CLI authentication
- Sensitive AWS Account ID excluded from public screenshots
- Root account reserved for exceptional administrative operations
- Cloud resources removed after testing

---

## Key Commands

AWS CLI version:

`aws --version`

AWS authentication:

`aws login`

Validate identity:

`aws sts get-caller-identity`

Check region:

`aws configure get region`

IAM account summary:

`aws iam get-account-summary`

List IAM users:

`aws iam list-users`

List IAM roles:

`aws iam list-roles`

List S3 buckets:

`aws s3 ls`

List bucket contents:

`aws s3 ls s3://marcos-cloud-lab-s3-2026/`

Upload:

`aws s3 cp cloudlab.txt s3://marcos-cloud-lab-s3-2026/`

Download:

`aws s3 cp s3://marcos-cloud-lab-s3-2026/cloudlab.txt download-test/cloudlab-downloaded.txt`

Delete object:

`aws s3 rm s3://marcos-cloud-lab-s3-2026/cloudlab.txt`

Delete bucket:

`aws s3api delete-bucket --bucket marcos-cloud-lab-s3-2026 --region sa-east-1`

---

## Result

AWS CLI was successfully installed and authenticated from Ubuntu Linux.

The lab demonstrated practical administration of AWS resources through the command line, including identity validation, IAM inspection and the complete lifecycle of an Amazon S3 object and bucket.

## Key Learning

AWS CLI provides a powerful way to administer AWS resources directly from Linux.

IAM controls identity and permissions, STS helps work with temporary security credentials and Amazon S3 provides scalable object storage.

Cloud administration also includes proper security practices, resource validation and cleanup after resources are no longer required.
