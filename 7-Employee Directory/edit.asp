
<%@ Language="VBScript" %>
<% Option Explicit %>
<!--#include file="includes/db.asp" -->

<%
Const adCmdText = 1
Const adParamInput = 1
Const adInteger = 3
Const adVarWChar = 202
Const adDBDate = 133

Dim id, fullName, email, position, department, hireDate
Dim cmd, rs, errorMessage

id = CLng(Request("id"))

' ---------- UPDATE ----------
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

    fullName = Trim(Request.Form("FullName"))
    email = Trim(Request.Form("Email"))
    position = Trim(Request.Form("Position"))
    department = Trim(Request.Form("Department"))
    hireDate = Trim(Request.Form("HireDate"))

    If fullName="" Or email="" Or position="" _
       Or department="" Or hireDate="" Then

        errorMessage = "All fields are required."

    Else

        Set cmd = Server.CreateObject("ADODB.Command")
        Set cmd.ActiveConnection = conn
        cmd.CommandType = adCmdText

        cmd.CommandText = _
        "UPDATE Employees SET FullName=?, Email=?, Position=?, Department=?, HireDate=? WHERE EmployeeID=?"

        cmd.Parameters.Append cmd.CreateParameter("@FullName", adVarWChar, adParamInput,100, fullName)
        cmd.Parameters.Append cmd.CreateParameter("@Email", adVarWChar, adParamInput,100, email)
        cmd.Parameters.Append cmd.CreateParameter("@Position", adVarWChar, adParamInput,100, position)
        cmd.Parameters.Append cmd.CreateParameter("@Department", adVarWChar, adParamInput,100, department)
        cmd.Parameters.Append cmd.CreateParameter("@HireDate", adDBDate, adParamInput,, CDate(hireDate))
        cmd.Parameters.Append cmd.CreateParameter("@EmployeeID", adInteger, adParamInput,, id)

        cmd.Execute

        Response.Redirect "index.asp"

    End If

Else

    ' ---------- LOAD EMPLOYEE ----------
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = conn
    cmd.CommandType = adCmdText
    cmd.CommandText = "SELECT * FROM Employees WHERE EmployeeID=?"

    cmd.Parameters.Append cmd.CreateParameter("@EmployeeID", adInteger, adParamInput,, id)

    Set rs = cmd.Execute

    If rs.EOF Then
        Response.Write "Employee not found."
        Response.End
    End If

    fullName = rs("FullName")
    email = rs("Email")
    position = rs("Position")
    department = rs("Department")
    hireDate = Year(rs("HireDate")) & "-" & Right("0"&Month(rs("HireDate")),2) & "-" & Right("0"&Day(rs("HireDate")),2)

End If

Function H(v)
    H = Server.HTMLEncode(CStr(v))
End Function
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Employee</title>
<style>
body{font-family:Arial;background:#f3f4f6;padding:30px}
.container{max-width:600px;margin:auto;background:white;padding:25px;border-radius:8px}
input{width:100%;padding:10px;margin:8px 0}
button{padding:10px 18px}
.error{color:red}
</style>
</head>
<body>

<div class="container">

<h2>Edit Employee</h2>

<% If errorMessage<>"" Then %>
<p class="error"><%=H(errorMessage)%></p>
<% End If %>

<form method="post">

<label>Full Name</label>
<input type="text" name="FullName" value="<%=H(fullName)%>" required maxlength="100">

<label>Email</label>
<input type="email" name="Email" value="<%=H(email)%>" required maxlength="100">

<label>Position</label>
<input type="text" name="Position" value="<%=H(position)%>" required maxlength="100">

<label>Department</label>
<input type="text" name="Department" value="<%=H(department)%>" required maxlength="100">

<label>Hire Date</label>
<input type="date" name="HireDate" value="<%=H(hireDate)%>" required>

<button type="submit">Update Employee</button>
<a href="index.asp">Cancel</a>

</form>

</div>

</body>
</html>

<%
conn.Close
Set conn = Nothing
%>
