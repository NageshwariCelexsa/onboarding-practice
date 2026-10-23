# Employee Directory — Classic ASP Capstone

## 1. Project Overview

The Employee Directory is a full-stack web application built using HTML, CSS, JavaScript, Classic ASP, VBScript, ADO, and Microsoft SQL Server.

It allows users to manage employee records through a web interface connected to the `InternTraining` database.

### Features

- **Create:** Add employee records.
- **Read:** Display employee records in a table.
- **Search:** Search employees by name, email, position, and department.
- **Update:** Edit existing employee details.
- **Delete:** Delete employee records with confirmation.
- **Validation:** Client-side and server-side validation.
- **Security:** Parameterized SQL commands and HTML output encoding.

## 2. Technologies Used

- HTML5
- CSS3
- JavaScript
- Classic ASP and VBScript
- ADO (ActiveX Data Objects)
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- IIS with Classic ASP enabled

## 3. Project Structure

```text
7- Employee Directory/
├── index.asp
├── add.asp
├── edit.asp
├── delete.asp
├── includes/
│   └── db.asp
├── css/
├── js/
├── database.sql
├── README.md
└── screenshots/
    ├── list-view.png
    ├── add-form.png
    └── edit-form.png
```

The `css/` and `js/` folders can contain the application's external stylesheets and JavaScript files. Adjust this structure to reflect the files actually present in your project.

## 4. Prerequisites

Install or enable the following:

1. Windows with Internet Information Services (IIS).
2. Classic ASP under IIS Application Development Features.
3. Microsoft SQL Server Express.
4. SQL Server Management Studio.
5. Microsoft OLE DB Driver for SQL Server.
6. A modern web browser.

## 5. Database Setup

The application uses the SQL Server instance `localhost\SQLEXPRESS` and database `InternTraining`.

The `Employees` table contains these columns:

| Column | Data type |
|---|---|
| EmployeeID | INT |
| FullName | NVARCHAR(100) |
| Email | NVARCHAR(100) |
| Position | NVARCHAR(100) |
| Department | NVARCHAR(100) |
| HireDate | DATE |

To inspect the existing table, open SSMS, connect to `localhost\SQLEXPRESS`, select `InternTraining`, and execute:

```sql
USE InternTraining;
GO

SELECT *
FROM dbo.Employees
ORDER BY EmployeeID DESC;
GO
```

If setting up a fresh database, execute the project's `database.sql` script after verifying that it matches the required schema. Do not recreate an existing table unnecessarily.

## 6. Database Connection

The connection file is `includes/db.asp`.

The application uses an ADO connection with the Microsoft OLE DB Driver for SQL Server and Windows Integrated Authentication.

Configure the connection string for the target SQL Server instance. The IIS application identity must have the necessary database permissions.

Do not commit database passwords or other secrets to a public repository.

## 7. IIS Deployment

1. Enable IIS and the Classic ASP feature through Windows Features.
2. Open IIS Manager.
3. Create a website or application pointing to the project directory.
4. Configure the appropriate binding, hostname, and port.
5. Ensure the IIS application identity has read and execute access to the project files.
6. Grant only the required database permissions to the application identity.
7. Confirm that the required OLE DB provider is installed.
8. Browse to the configured website's `index.asp` page.

Example URL:

```text
http://localhost/EmployeeDirectory/index.asp
```

Replace `EmployeeDirectory` with the actual IIS application path.

Classic ASP must be executed by IIS with the Classic ASP feature enabled. Opening `.asp` files directly from disk or serving them through an ASP.NET-only development server will not execute the VBScript.

Parent Paths need not be enabled when using the relative include paths shown in this project. Enable them only if your application specifically requires them and the security implications have been reviewed.

## 8. Application Usage

### List and Search

Open `index.asp` to view the employee directory. Use the search field to filter records.

### Add Employee

Select **Add Employee**, enter the employee's details, and submit the form. The server validates the submitted values and inserts the record into SQL Server.

### Edit Employee

Select **Edit** next to an employee, modify the fields, and save the changes.

### Delete Employee

Select **Delete** and confirm the action. The server processes the deletion using a parameterized command.

## 9. Security and Validation

The application is designed to follow these practices:

- Use ADO Command objects and parameterized SQL for data operations.
- Validate submitted data on the server rather than relying exclusively on browser validation.
- Use JavaScript to provide immediate feedback to users.
- Encode database values rendered into HTML using `Server.HTMLEncode`.
- Use POST for state-changing operations.
- Add CSRF protection to state-changing forms before production deployment.
- Handle database errors without exposing connection strings or sensitive internal details.
- Apply least-privilege database permissions.

All database operations should be reviewed to ensure that no user-supplied value is concatenated directly into an SQL statement.

## 10. Screenshots

Store screenshots of the working application in the `screenshots/` directory.

### List View

![Employee Directory List View](screenshots/list-view.png)

### Add Employee Form

![Add Employee Form](screenshots/add-form.png)

### Edit Employee Form

![Edit Employee Form](screenshots/edit-form.png)

Replace these image files with actual screenshots captured from the running application.

## 11. Testing Checklist

- [ ] Employee list displays records from SQL Server.
- [ ] Search filters the employee list correctly.
- [ ] Valid employee details can be added.
- [ ] Invalid or missing fields are rejected.
- [ ] Existing employee details can be updated.
- [ ] Employee deletion requires confirmation and uses POST.
- [ ] Database changes persist after refreshing the page.
- [ ] SQL commands use parameters.
- [ ] HTML output is encoded.
- [ ] IIS deployment and database permissions are verified.

## 12. Conclusion

This project demonstrates a complete employee management workflow using Classic ASP, VBScript, ADO, and SQL Server. It combines CRUD operations, validation, database connectivity, and secure query practices in a legacy web application environment.
