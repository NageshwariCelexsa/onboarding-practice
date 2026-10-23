
<%@ Language="VBScript" %>
<% Option Explicit %>
<!--#include file="includes/db.asp" -->
<%
Const adCmdText = 1
Const adParamInput = 1
Const adVarWChar = 202
Const adDBDate = 133

Dim fullName, email, position, department, hireDate
Dim errorMessage, successMessage, cmd

fullName = Trim(Request.Form("FullName"))
email = Trim(Request.Form("Email"))
position = Trim(Request.Form("Position"))
department = Trim(Request.Form("Department"))
hireDate = Trim(Request.Form("HireDate"))

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

    If fullName = "" Or email = "" Or position = "" _
       Or department = "" Or hireDate = "" Then

        errorMessage = "All fields are required."

    ElseIf Len(fullName) > 100 Or Len(email) > 100 _
       Or Len(position) > 100 Or Len(department) > 100 Then

        errorMessage = "Text fields must not exceed 100 characters."

    ElseIf InStr(email, "@") = 0 Or InStr(email, ".") = 0 Then

        errorMessage = "Enter a valid email address."

    ElseIf Not IsDate(hireDate) Then

        errorMessage = "Enter a valid hire date."

    Else
        On Error Resume Next

        Set cmd = Server.CreateObject("ADODB.Command")
        Set cmd.ActiveConnection = conn
        cmd.CommandType = adCmdText
        cmd.CommandText = _
            "INSERT INTO dbo.Employees " & _
            "(FullName, Email, Position, Department, HireDate) " & _
            "VALUES (?, ?, ?, ?, ?)"

        cmd.Parameters.Append cmd.CreateParameter( _
            "@FullName", adVarWChar, adParamInput, 100, fullName)

        cmd.Parameters.Append cmd.CreateParameter( _
            "@Email", adVarWChar, adParamInput, 100, email)

        cmd.Parameters.Append cmd.CreateParameter( _
            "@Position", adVarWChar, adParamInput, 100, position)

        cmd.Parameters.Append cmd.CreateParameter( _
            "@Department", adVarWChar, adParamInput, 100, department)

        Dim dateValue
        dateValue = CDate(hireDate)

        cmd.Parameters.Append cmd.CreateParameter( _
            "@HireDate", adDBDate, adParamInput, , dateValue)

        cmd.Execute

        If Err.Number <> 0 Then
            errorMessage = "Could not save the employee. Check that the email is unique and the database is available."
            Err.Clear
        Else
            Response.Redirect "index.asp"
        End If

        Set cmd = Nothing
        On Error GoTo 0
    End If
End If

Function H(value)
    H = Server.HTMLEncode(CStr(value))
End Function
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add Employee</title>
<style>
body{font-family:Arial,sans-serif;background:#f3f4f6;padding:30px}
main{max-width:600px;margin:auto;background:white;padding:24px;border-radius:8px}
label{display:block;margin-top:14px}
input{box-sizing:border-box;width:100%;padding:10px;margin-top:5px}
button{padding:10px 18px;margin-top:18px;cursor:pointer}
.error{color:#b91c1c}
</style>
</head>
<body>
<main>
<h1>Add Employee</h1>

<% If errorMessage <> "" Then %>
<p class="error" role="alert"><%=H(errorMessage)%></p>
<% End If %>

<form method="post" action="add.asp" id="employeeForm">
<label for="FullName">Full Name</label>
<input id="FullName" name="FullName" maxlength="100"
 required value="<%=H(fullName)%>">

<label for="Email">Email</label>
<input id="Email" name="Email" type="email" maxlength="100"
 required value="<%=H(email)%>">

<label for="Position">Position</label>
<input id="Position" name="Position" maxlength="100"
 required value="<%=H(position)%>">

<label for="Department">Department</label>
<input id="Department" name="Department" maxlength="100"
 required value="<%=H(department)%>">

<label for="HireDate">Hire Date</label>
<input id="HireDate" name="HireDate" type="date"
 required value="<%=H(hireDate)%>">

<p id="clientError" class="error" role="alert"></p>
<button type="submit">Save Employee</button>
<a href="index.asp">Cancel</a>
</form>
</main>

<script>
document.getElementById("employeeForm").addEventListener("submit", function(event) {
    const email = document.getElementById("Email").value.trim();
    const error = document.getElementById("clientError");
    error.textContent = "";

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        event.preventDefault();
        error.textContent = "Please enter a valid email address.";
    }
});
</script>
</body>
</html>
<%
conn.Close
Set conn = Nothing
%>
