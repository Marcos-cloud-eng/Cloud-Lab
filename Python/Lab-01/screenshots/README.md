# Python Lab 01 - Linux Automation Fundamentals

## Overview

This lab demonstrates the use of Python to automate common Linux administration tasks.

The project focuses on filesystem automation, system information collection, report generation, log analysis, and exception handling.

## Environment

- Ubuntu Linux
- Python 3
- Bash
- Git
- GitHub

Python executable:

```bash
/usr/bin/python3
```

## Lab Structure

```text
Python/Lab-01/
├── README.md
├── data/
│   ├── files/
│   ├── reports/
│   └── sample_logs.txt
├── screenshots/
└── scripts/
    ├── file_manager.py
    ├── log_checker.py
    └── system_report.py
```

## Objectives

- Practice Python automation on Linux
- Work with files and directories
- Use Python dictionaries and loops
- Implement conditional logic
- Read and write files
- Collect Linux system information
- Generate system reports
- Analyze log files
- Implement exception handling
- Organize scripts using a structured project layout

---

## 1. File Manager

Script:

```text
scripts/file_manager.py
```

The File Manager automates filesystem organization based on file extensions.

The script uses:

```python
from pathlib import Path
import shutil
```

A dictionary maps extensions to destination directories:

```python
folders = {
    ".txt": "text",
    ".log": "logs",
    ".json": "json",
    ".png": "images"
}
```

The script:

1. Scans files in the source directory
2. Detects each file extension
3. Creates destination directories when necessary
4. Moves files to the appropriate directory
5. Reports the operations in the terminal

Example result:

```text
files/
├── images/
│   └── image.png
├── json/
│   └── config.json
├── logs/
│   └── system.log
└── text/
    └── report.txt
```

### Concepts Practiced

- `pathlib`
- `shutil`
- Dictionaries
- `for` loops
- `if / else`
- Filesystem paths
- Directory creation
- File movement

---

## 2. Linux System Report

Script:

```text
scripts/system_report.py
```

This script collects information directly from the Linux system.

Information collected includes:

- Hostname
- Current user
- Operating system
- Kernel version
- System architecture
- Disk capacity
- Used disk space
- Free disk space
- Report generation date and time

Modules used:

```python
import os
import platform
import shutil
from datetime import datetime
from pathlib import Path
```

Disk information is collected with:

```python
shutil.disk_usage("/")
```

The generated report is automatically saved to:

```text
data/reports/system_report.txt
```

### Concepts Practiced

- Python standard library
- Environment variables
- Linux system information
- Numeric calculations
- String formatting
- File output
- Report generation

---

## 3. Log Checker

Script:

```text
scripts/log_checker.py
```

The Log Checker reads a sample log file and identifies three severity levels:

```text
INFO
WARNING
ERROR
```

A Python dictionary stores the counters:

```python
counts = {
    "INFO": 0,
    "WARNING": 0,
    "ERROR": 0
}
```

The file is processed line by line and the corresponding counters are incremented.

Example output:

```text
LOG ANALYSIS
------------------------------
INFO: 5
WARNING: 2
ERROR: 3
```

### Concepts Practiced

- File reading
- Dictionaries
- Loops
- Conditional statements
- String matching
- Counters

---

## Exception Handling

The Log Checker also implements error handling using:

```python
try:
```

and:

```python
except FileNotFoundError:
```

A troubleshooting test was performed by temporarily renaming the log file.

Instead of crashing, the script returned:

```text
Log file not found: ../data/sample_logs.txt
```

Unexpected exceptions are also captured with:

```python
except Exception as error:
```

This demonstrates how automation scripts can fail gracefully and provide useful troubleshooting information.

---

## Running the Scripts

From the `scripts` directory:

```bash
python3 file_manager.py
python3 system_report.py
python3 log_checker.py
```

The project structure and generated files can be inspected with:

```bash
tree ../data
```

---

## Key Python Concepts

This lab covered:

- Variables
- Strings
- Lists
- Dictionaries
- `for` loops
- `if / elif / else`
- Modules
- `Path`
- File I/O
- f-strings
- Exception handling
- Linux filesystem automation

---

## Troubleshooting

### Working Directory

The scripts use relative paths such as:

```text
../data/files
```

Therefore, they were executed from the `scripts` directory.

### Missing Log File

The log file was intentionally renamed to simulate a failure.

The `FileNotFoundError` exception was successfully handled without terminating the script unexpectedly.

---

## Result

Three Python automation scripts were successfully created and tested on Ubuntu Linux:

- File organization automation
- Linux system report generation
- Log file analysis

The lab demonstrates how Python can be used to automate repetitive Linux administration tasks and provides a foundation for Cloud and Infrastructure automation.

## Next Lab

**Python Lab 02 - API and JSON Automation**

The next lab will expand into:

- JSON
- REST APIs
- HTTP requests
- API responses
- Command-line arguments
- Automation using external data
