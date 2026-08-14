# Packing Services Follow-up Automation

## Overview

This project documents a real business process automation created with Microsoft Power Automate.

The goal of the flow is to automatically remind the move coordination team to report upcoming packing and unpacking services that may require team or service provider evaluation.

---

## Business Problem

Packing and unpacking services must be monitored for operational quality and provider evaluation.

However, relying only on manual communication can result in missed services or delayed information.

The automation creates a recurring communication process between the evaluation team and move coordinators.

---

## Solution

A scheduled cloud flow was created in Microsoft Power Automate.

The flow automatically sends an email to the coordination team every:

- Monday at 09:00 AM
- Thursday at 09:00 AM

Time zone:

`UTC-03:00 Brasilia`

The email requests information about packing and unpacking services scheduled for the current or following week.

---

## Automation Flow

```text
Recurrence Trigger
       |
       v
Send an Email (V2)
       |
       v
Coordination Team Receives Request
       |
       v
Coordinator Reports Upcoming Services
       |
       v
Service Added to Evaluation Schedule
       |
       v
Service Evaluation Performed
       |
       v
Evaluation Status Returned to Coordination