# Python Lab 02 - API and JSON Automation

## Overview

This lab demonstrates how Python can interact with a REST API, process JSON data, handle HTTP errors, and generate automated reports on Linux.

The project builds on the automation concepts from Python Lab 01 and introduces API communication and structured data processing.

## Environment

- Ubuntu Linux
- Python 3
- Python Virtual Environment (`venv`)
- Requests
- REST API
- JSON
- Bash
- Git
- GitHub

## Lab Structure

```text
Python/Lab-02/
├── README.md
├── data/
│   ├── api_response.json
│   └── reports/
│       └── api_report.txt
├── screenshots/
└── scripts/
    ├── api_client.py
    ├── api_report.py
    └── json_parser.py
```

## Objectives

- Consume a REST API using Python
- Perform an HTTP GET request
- Validate HTTP status codes
- Process API responses
- Work with JSON data
- Save API responses to files
- Parse nested JSON structures
- Handle request and JSON errors
- Generate automated reports
- Use a Python virtual environment
- Practice Linux-based Python automation

---

## 1. API Client

Script:

```text
scripts/api_client.py
```

The API client uses the Python `requests` library to communicate with a REST API.

The lab uses JSONPlaceholder as a public testing API:

```text
https://jsonplaceholder.typicode.com/users
```

The request is performed with:

```python
response = requests.get(
    url,
    timeout=10
)
```

The HTTP response status is displayed with:

```python
response.status_code
```

A successful request returned:

```text
Status Code: 200
```

HTTP status `200` indicates that the request was successfully processed.

The script also uses:

```python
response.raise_for_status()
```

to raise an exception when an HTTP error occurs.

---

## 2. Processing the API Response

The JSON response is converted into Python data structures using:

```python
data = response.json()
```

The returned structure contains a list of users.

Python can access individual fields using dictionary keys:

```python
data[0]["name"]
data[0]["email"]
data[0]["address"]["city"]
```

The `address` example demonstrates access to nested JSON data.

---

## 3. Saving JSON Data

The API response is stored locally in:

```text
data/api_response.json
```

The `json` module is used to serialize Python data into JSON:

```python
json.dump(
    data,
    file,
    indent=4,
    ensure_ascii=False
)
```

The file is written using UTF-8 encoding:

```python
encoding="utf-8"
```

This ensures proper handling of international and special characters.

---

## 4. JSON Parser

Script:

```text
scripts/json_parser.py
```

The JSON Parser reads the previously saved API response:

```python
with open(json_file, "r", encoding="utf-8") as file:
    data = json.load(file)
```

`json.load()` converts JSON stored in a file back into Python objects.

The script iterates through the users:

```python
for user in data:
```

and extracts:

- Name
- Email
- City

Example:

```python
name = user["name"]
email = user["email"]
city = user["address"]["city"]
```

### Concepts Practiced

- Lists
- Dictionaries
- Loops
- Nested JSON
- File reading
- JSON deserialization

---

## 5. Automated API Report

Script:

```text
scripts/api_report.py
```

The final script transforms the JSON data into a human-readable report.

For each user, the report contains:

- Name
- Email
- City
- Company

The report also includes:

- Generation timestamp
- Total number of users

The generated report is stored in:

```text
data/reports/api_report.txt
```

The report is constructed using a Python list:

```python
report_lines = []
```

Individual lines are added with:

```python
report_lines.append()
```

The final text is generated using:

```python
report = "\n".join(report_lines)
```

and written to disk using:

```python
with open(report_file, "w", encoding="utf-8") as file:
    file.write(report)
```

---

## 6. Exception Handling

The scripts implement exception handling for API and JSON operations.

HTTP-related failures are handled using:

```python
except requests.exceptions.RequestException as error:
```

Missing files are handled using:

```python
except FileNotFoundError:
```

Invalid JSON is handled using:

```python
except json.JSONDecodeError:
```

Unexpected errors are handled using:

```python
except Exception as error:
```

This prevents the automation from failing without providing useful diagnostic information.

---

## 7. Virtual Environment

A Python virtual environment was used to isolate project dependencies.

The environment was activated with:

```bash
source .venv/bin/activate
```

The `requests` package was installed inside the environment.

This prevents project dependencies from modifying the system Python environment.

---

## Data Flow

```text
REST API
   |
   v
HTTP GET
   |
   v
requests
   |
   v
JSON Response
   |
   v
api_response.json
   |
   v
json.load()
   |
   v
Python Processing
   |
   v
api_report.txt
```

---

## Running the Lab

Activate the virtual environment:

```bash
cd ~/Cloud-Lab/Python/Lab-02
source .venv/bin/activate
```

Run the API client:

```bash
cd scripts
python api_client.py
```

Parse the JSON:

```bash
python json_parser.py
```

Generate the report:

```bash
python api_report.py
```

Inspect the generated report:

```bash
cat ../data/reports/api_report.txt
```

---

## Key Concepts

This lab covered:

- REST APIs
- HTTP GET
- HTTP status codes
- Python `requests`
- JSON
- `response.json()`
- `json.dump()`
- `json.load()`
- Lists
- Dictionaries
- Nested data
- Loops
- UTF-8
- File I/O
- Exception handling
- Virtual environments
- Automated report generation

---

## Result

A complete Python API automation workflow was successfully created and tested on Ubuntu Linux.

The project:

1. Connects to a REST API
2. Performs an HTTP GET request
3. Validates the HTTP response
4. Converts the response to Python data
5. Stores the response as JSON
6. Reads and parses the JSON file
7. Extracts nested information
8. Generates a human-readable report
9. Handles API and data-processing errors

This lab demonstrates how Python can be used as an automation layer between external services, structured data, Linux, and operational reporting.

## Next Steps

Future Python labs can expand this foundation with authentication, command-line arguments, environment variables, cloud SDKs, and infrastructure automation.
