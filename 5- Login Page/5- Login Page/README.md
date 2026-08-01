# Task 5 – Login Page (ASP.NET Web Forms)

## Overview

This project demonstrates a simple login page using ASP.NET Web Forms with server-side validation.

### Dummy Credentials

Username: admin

Password: Password123

> These credentials are hardcoded only for learning purposes.

---

## IIS Setup

1. Open IIS Manager.
2. Right-click **Sites**.
3. Select **Add Website**.
4. Site Name:
   ```
   LoginPage
   ```
5. Physical Path:
   ```
   Select the 5- Login Page project folder.
   ```
6. Port:
   ```
   8085 (or any available port)
   ```
7. Click OK.

---

## Application Pool

Use:

```
.NET CLR Version: v4.0
Managed Pipeline Mode: Integrated
```

Target Framework:

```
.NET Framework 4.8
```

---

## Folder Permissions

Grant the following users Read & Execute permission:

- IIS_IUSRS
- IUSR

If write operations are added in future, Modify permission may also be required.

---

## Validation

This application performs:

- HTML RequiredFieldValidator
- Server-side validation in C#
- Trims username before validation
- Checks for empty username/password
- Validates dummy credentials

---

## Security Notes

For learning purposes only.

Hardcoding credentials is NOT recommended in production.

In a real application:

- Store users in a database.
- Store passwords as salted hashes (never plaintext).
- Use HTTPS.
- Implement account lockout after repeated failed attempts.
- Use ASP.NET Identity or another secure authentication framework.

The application never displays the entered password back to the user and returns only the generic message:

```
Invalid username or password.
```

This prevents attackers from determining whether the username or password was incorrect.