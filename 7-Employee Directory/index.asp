
<%@ Language="VBScript" %>
<% Option Explicit %>
<!--#include file="includes/db.asp" -->
<%
Const adCmdText = 1
Const adParamInput = 1
Const adVarWChar = 202

Dim searchTerm, cmd, rs
searchTerm = Trim(Request.QueryString("search"))

If Len(searchTerm) > 100 Then
    searchTerm = Left(searchTerm, 100)
End If

Set cmd = Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection = conn
cmd.CommandType = adCmdText

If Len(searchTerm) > 0 Then
    cmd.CommandText = _
        "SELECT EmployeeID, FullName, Email, Position, Department, HireDate " & _
        "FROM dbo.Employees " & _
        "WHERE FullName LIKE ? OR Email LIKE ? " & _
        "OR Position LIKE ? OR Department LIKE ? " & _
        "ORDER BY EmployeeID DESC"

    Dim pattern
    pattern = "%" & searchTerm & "%"

    cmd.Parameters.Append cmd.CreateParameter("@p1", adVarWChar, adParamInput, 102, pattern)
    cmd.Parameters.Append cmd.CreateParameter("@p2", adVarWChar, adParamInput, 102, pattern)
    cmd.Parameters.Append cmd.CreateParameter("@p3", adVarWChar, adParamInput, 102, pattern)
    cmd.Parameters.Append cmd.CreateParameter("@p4", adVarWChar, adParamInput, 102, pattern)
Else
    cmd.CommandText = _
        "SELECT EmployeeID, FullName, Email, Position, Department, HireDate " & _
        "FROM dbo.Employees ORDER BY EmployeeID DESC"
End If

Set rs = cmd.Execute

Function H(value)
    If IsNull(value) Then
        H = ""
    Else
        H = Server.HTMLEncode(CStr(value))
    End If
End Function
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Employee Directory</title>
<style>
body{font-family:Arial,sans-serif;background:#f3f4f6;margin:0;padding:30px}
main{max-width:1100px;margin:auto;background:white;padding:24px;border-radius:8px}
input,button{padding:10px;box-sizing:border-box}
input{max-width:100%}
table{width:100%;border-collapse:collapse;margin-top:20px}
th,td{border:1px solid #ddd;padding:10px;text-align:left}
th{background:#edf2f7}
.actions{display:flex;gap:10px;flex-wrap:wrap}
</style>
</head>
<body>
<main>
<h1>Employee Directory</h1>

<p><a href="add.asp">Add Employee</a></p>

<form method="get" action="index.asp">
<label for="search">Search employees</label>
<input id="search" name="search" maxlength="100"
       value="<%=H(searchTerm)%>">
<button type="submit">Search</button>
<a href="index.asp">Clear</a>
</form>

<table>
<thead>
<tr>
<th>ID</th><th>Name</th><th>Email</th>
<th>Position</th><th>Department</th><th>Hire Date</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<%
If rs.EOF Then
    Response.Write "<tr><td colspan=""7"">No employees found.</td></tr>"
Else
    Do Until rs.EOF
%>
<tr>
<td><%=H(rs("EmployeeID"))%></td>
<td><%=H(rs("FullName"))%></td>
<td><%=H(rs("Email"))%></td>
<td><%=H(rs("Position"))%></td>
<td><%=H(rs("Department"))%></td>
<td><%=H(rs("HireDate"))%></td>
<td class="actions">
<a href="edit.asp?id=<%=H(rs("EmployeeID"))%>">Edit</a>

<form method="post" action="delete.asp"
      onsubmit="return confirm('Are you sure you want to delete this employee?');"
      style="display:inline">
    <input type="hidden" name="EmployeeID"
           value="<%=H(rs("EmployeeID"))%>">
    <button type="submit">Delete</button>
</form>

</td>
</tr>
<%
        rs.MoveNext
    Loop
End If

rs.Close
Set rs = Nothing
Set cmd = Nothing
conn.Close
Set conn = Nothing
%>
</tbody>
</table>
</main>
</body>
</html>
