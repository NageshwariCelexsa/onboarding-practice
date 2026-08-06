# Employee Directory

## Project Overview

Employee Directory is an ASP.NET Web Forms application that performs complete CRUD (Create, Read, Update, Delete) operations on employee records stored in a SQL Server database.

## Technologies Used

- ASP.NET Web Forms (.NET Framework 4.8)
- C#
- SQL Server
- HTML
- CSS
- JavaScript

## Features

- Add Employee
- View Employee List
- Search Employee by Name or Department
- Edit Employee
- Delete Employee
- Client-side Validation
- Server-side Validation
- Parameterized SQL Queries (SQL Injection Prevention)

---

# Database Setup

## Prerequisites

- Visual Studio 2022
- SQL Server Express
- SQL Server Management Studio (SSMS)
- IIS (Internet Information Services)

## Create Database

Run the SQL script below:

```sql
CREATE DATABASE InternTraining;
GO

USE InternTraining;
GO

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Position NVARCHAR(100) NOT NULL,
    Department NVARCHAR(100) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees
(FullName,Email,Position,Department,HireDate)
VALUES
('John Smith','john@example.com','Developer','IT','2023-01-15'),
('Emily Johnson','emily@example.com','HR Executive','HR','2022-06-20'),
('David Miller','david@example.com','Manager','Sales','2021-11-10');
```

---

# Connection String

Update the connection string in **Web.config**.

```xml
<connectionStrings>
    <add name="EmployeeDB"
         connectionString="Data Source=localhost\SQLEXPRESS;Initial Catalog=InternTraining;Integrated Security=True;TrustServerCertificate=True"
         providerName="System.Data.SqlClient"/>
</connectionStrings>
```

---

# Running the Project

1. Open the project in Visual Studio.
2. Restore NuGet packages if prompted.
3. Build the solution.
4. Press **F5** to run the application.

---

# IIS Deployment

1. Open IIS Manager.
2. Create a new website.
3. Site Name:
   ```
   EmployeeDirectory
   ```
4. Physical Path:
   Select the project folder.
5. Assign an available port (for example 8085).
6. Click **OK**.
7. Browse the website.

---

# Validation

## Client-side

- Required fields
- Email format validation
- JavaScript validation before submitting

## Server-side

- Required field validation
- Parameterized SQL queries
- SQL Injection prevention

---

# CRUD Operations

### Create
Add a new employee.

### Read
Display all employees in GridView.

### Update
Edit an existing employee.

### Delete
Delete an employee record.

### Search
Search employees by Name or Department.

---

# Screenshots

Add the following screenshots to the project.

```
Screenshots/
│
├── ListView.png
├── AddEmployee.png
├── EditEmployee.png
├── SearchEmployee.png
└── DeleteEmployee.png
```

Then insert them here.

## List View

*(Insert screenshot here)*

## Add Employee

*(Insert screenshot here)*

## Edit Employee

*(Insert screenshot here)*

## Search Employee

*(Insert screenshot here)*

## Delete Employee

*(Insert screenshot here)*

---

# Security

- Parameterized SQL Commands
- Input Validation
- Server-side Validation
- Client-side Validation
- SQL Injection Prevention

---

# Author

**Name:** Nageshwari S
