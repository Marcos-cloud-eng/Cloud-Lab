# MySQL Lab 01 - Database Fundamentals and CRUD

## Scenario

This lab introduces practical relational database administration using MySQL in an Ubuntu Linux environment.

The objective was to install MySQL, create a database and table, insert and manipulate records, run filtered queries and practice basic data analysis using SQL.

## Objectives

- Install MySQL on Ubuntu
- Validate the MySQL service
- Access MySQL through the terminal
- Create a database
- Create a table
- Understand Primary Keys
- Insert records
- Query data using SELECT
- Filter records using WHERE
- Update records
- Delete records
- Sort results with ORDER BY
- Count records with COUNT
- Calculate averages with AVG
- Group data with GROUP BY
- Practice CRUD operations

## Environment

- Ubuntu Linux
- MySQL Server
- MySQL CLI
- Git
- GitHub

## MySQL Installation

MySQL was installed using:

`sudo apt update`

`sudo apt install mysql-server -y`

The installation was validated using:

`mysql --version`

The MySQL service was checked using:

`sudo systemctl status mysql`

## Accessing MySQL

MySQL was accessed using:

`sudo mysql`

After authentication, the prompt changed to:

`mysql>`

## Database Creation

A database named `cloudlab` was created:

`CREATE DATABASE cloudlab;`

Available databases were listed using:

`SHOW DATABASES;`

The database was selected using:

`USE cloudlab;`

## Table Creation

A table named `employees` was created with the following structure:

- id
- name
- role
- department
- salary

SQL used:

`CREATE TABLE employees (`

`id INT AUTO_INCREMENT PRIMARY KEY,`

`name VARCHAR(100) NOT NULL,`

`role VARCHAR(100),`

`department VARCHAR(100),`

`salary DECIMAL(10,2)`

`);`

The table structure was validated using:

`DESCRIBE employees;`

## Primary Key

The `id` column was configured as:

`PRIMARY KEY`

and:

`AUTO_INCREMENT`

This allows MySQL to automatically generate a unique identifier for every employee record.

## INSERT

Employee records were added using:

`INSERT INTO employees (...) VALUES (...);`

This demonstrated how new records are created inside a relational database table.

## SELECT

All records were displayed using:

`SELECT * FROM employees;`

Specific columns were also queried using:

`SELECT name, role, salary FROM employees;`

## WHERE

Filtered queries were practiced using:

`SELECT * FROM employees WHERE salary > 6000;`

and:

`SELECT name, role, salary FROM employees WHERE department = 'IT';`

The `WHERE` clause allows SQL queries to return only records matching specific conditions.

## UPDATE

Existing data was modified using:

`UPDATE employees`

`SET salary = 4500.00`

`WHERE name = 'Joao Lima';`

The result was validated using a SELECT query.

## DELETE

Records were removed using:

`DELETE FROM employees WHERE name = 'Carlos Souza';`

The table was then checked again using:

`SELECT * FROM employees;`

## CRUD

This lab covered the fundamental CRUD operations:

Create → INSERT

Read → SELECT

Update → UPDATE

Delete → DELETE

CRUD represents the basic lifecycle of data inside applications and database systems.

## ORDER BY

Records were sorted by salary using:

`SELECT * FROM employees ORDER BY salary DESC;`

Ascending order was also practiced using:

`ASC`

## COUNT

The total number of employees was calculated using:

`SELECT COUNT(*) AS total_employees FROM employees;`

## AVG

The average salary was calculated using:

`SELECT AVG(salary) AS average_salary FROM employees;`

## GROUP BY

Employees were grouped by department using:

`SELECT department, COUNT(*) AS total_employees FROM employees GROUP BY department;`

A more complete analysis was also performed:

`SELECT department, COUNT(*) AS employees, ROUND(AVG(salary), 2) AS avg_salary FROM employees GROUP BY department ORDER BY avg_salary DESC;`

This query combines:

- GROUP BY
- COUNT
- AVG
- ROUND
- ORDER BY

## Troubleshooting

### No Database Selected

The following error occurred:

`ERROR 1046 (3D000): No database selected`

The database still existed, but no database was active in the current session.

The issue was resolved using:

`USE cloudlab;`

Then:

`SHOW TABLES;`

and:

`SELECT * FROM employees;`

### Cancelling an Incomplete SQL Command

An unfinished SQL command was cancelled using:

`\c`

This cleared the current statement and returned to:

`mysql>`

## Useful Commands

Show databases:

`SHOW DATABASES;`

Select database:

`USE cloudlab;`

Show tables:

`SHOW TABLES;`

Describe table:

`DESCRIBE employees;`

Show all records:

`SELECT * FROM employees;`

Exit MySQL:

`exit;`

## Result

A functional MySQL environment was created and managed directly through the Ubuntu terminal.

The lab included:

- MySQL installation
- Database creation
- Table creation
- Primary Key
- Data insertion
- Data queries
- Filtering
- Updates
- Deletes
- Sorting
- Aggregation
- Grouping
- Troubleshooting

## Key Learning

SQL provides a structured way to store, query and manipulate relational data.

CRUD operations form the foundation of database interaction, while functions such as COUNT, AVG, GROUP BY and ORDER BY allow data to be analyzed and summarized.

The next lab will focus on relationships between tables, Foreign Keys and JOIN operations.
