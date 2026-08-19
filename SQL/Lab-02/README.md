# MySQL Lab 02 - Relationships, Foreign Keys and JOINs

## Scenario

This lab expands the MySQL environment created in Lab 01 by introducing relational database concepts.

The objective was to create multiple related tables, establish relationships using Primary Keys and Foreign Keys, and retrieve combined information using SQL JOIN operations.

## Objectives

- Create a dedicated database for the lab
- Create multiple relational tables
- Understand Primary Keys
- Understand Foreign Keys
- Create a one-to-many relationship
- Practice INNER JOIN
- Practice LEFT JOIN
- Combine JOIN with aggregate functions
- Identify and remove duplicate records
- Practice SQL troubleshooting

## Environment

- Ubuntu Linux
- MySQL Server
- MySQL CLI
- Git
- GitHub

## Database Creation

A dedicated database was created for the lab:

```sql
CREATE DATABASE cloudlab_lab02;
```

The database was selected using:

```sql
USE cloudlab_lab02;
```

## Departments Table

The `departments` table was created:

```sql
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
```

Departments were added:

```sql
INSERT INTO departments (department_name)
VALUES
('IT'),
('Cloud'),
('Data'),
('Infrastructure'),
('Sales');
```

## Employees Table

The `employees` table was created with a Foreign Key:

```sql
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);
```

## Primary Key and Foreign Key

The `department_id` column in `departments` is the Primary Key.

The `department_id` column in `employees` is a Foreign Key referencing the Primary Key in `departments`.

Relationship:

```text
departments
department_id (PK)
       |
       | 1:N
       |
employees
department_id (FK)
```

A Primary Key uniquely identifies a record.

A Foreign Key connects records between related tables.

## One-to-Many Relationship

The database implements a one-to-many relationship.

One department can contain multiple employees, while each employee references one department.

Example:

```text
Cloud
  |
  +-- Marcos - Cloud Engineer
  |
  +-- Lucas - Cloud Administrator
```

## INNER JOIN

An INNER JOIN was used to combine employee information with department information:

```sql
SELECT
    e.name,
    e.role,
    e.salary,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id;
```

The JOIN matches:

```text
employees.department_id
```

with:

```text
departments.department_id
```

This allows information stored in separate tables to be displayed together.

## LEFT JOIN

A LEFT JOIN was also practiced:

```sql
SELECT
    d.department_name,
    e.name,
    e.role,
    e.salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id;
```

Unlike INNER JOIN, LEFT JOIN returns all records from the left table even when there is no matching record in the right table.

## JOIN with Aggregate Functions

JOIN operations were combined with data analysis functions:

```sql
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;
```

This query combines:

- LEFT JOIN
- COUNT
- AVG
- ROUND
- GROUP BY
- ORDER BY

It provides the number of employees and average salary for each department.

## Duplicate Records Troubleshooting

During the lab, duplicate employee records were identified.

Duplicates were detected using:

```sql
SELECT name, COUNT(*)
FROM employees
GROUP BY name;
```

The duplicate records were removed by comparing their unique employee IDs:

```sql
DELETE e1
FROM employees e1
JOIN employees e2
    ON e1.name = e2.name
    AND e1.role = e2.role
    AND e1.department_id = e2.department_id
    AND e1.employee_id > e2.employee_id;
```

The lower `employee_id` was preserved while the duplicate record was removed.

## Table Rename Troubleshooting

The employees table was initially created with an incorrect name.

Instead of deleting and recreating the table, it was renamed:

```sql
RENAME TABLE employess TO employees;
```

This preserved the existing table structure and relationships.

## Key Concepts

### Primary Key

Uniquely identifies each record in a table.

### Foreign Key

Creates a relationship between tables by referencing a key in another table.

### INNER JOIN

Returns records that have matching relationships in both tables.

### LEFT JOIN

Returns all records from the left table and matching records from the right table.

### Relationship

The lab demonstrated a `1:N` relationship between departments and employees.

## Result

A relational MySQL database was successfully created with multiple connected tables.

The lab demonstrated:

- Relational database design
- Primary Keys
- Foreign Keys
- One-to-many relationships
- INNER JOIN
- LEFT JOIN
- Aggregate functions with JOINs
- Duplicate detection and removal
- SQL troubleshooting

## Key Learning

Relational databases separate information into related tables instead of repeatedly storing the same information.

Primary Keys identify records, Foreign Keys establish relationships, and JOIN operations allow related data from multiple tables to be queried together.

This provides a more organized, consistent and scalable database structure.
