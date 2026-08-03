# Task 6 - Feedback Form (Classic ASP)

## Description

This project demonstrates a self-posting feedback form using Classic ASP.

## Features

- Self-posting form (`action="feedback.asp"`)
- Detects GET and POST requests using:
  - `Request.ServerVariables("REQUEST_METHOD")`
- Reads submitted data using:
  - `Request.Form("username")`
  - `Request.Form("message")`
- Displays:
  - Name
  - Message
  - Current server time using `Now()`
- Prevents Cross-Site Scripting (XSS) by using:
  - `Server.HTMLEncode()`

## Files

- `feedback.asp`
- `Readme.md`

## How to Run

1. Place the folder inside your IIS website.
2. Start IIS.
3. Open:

```
http://localhost/6- Feedback Form/feedback.asp
```

4. Enter your feedback.
5. Click **Submit Feedback**.
6. The same page displays the submitted information safely.