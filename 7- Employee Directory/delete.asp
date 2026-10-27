
<%@ Language="VBScript" %>
<% Option Explicit %>
<!--#include file="includes/db.asp" -->
<%
Const adCmdText = 1
Const adParamInput = 1
Const adInteger = 3

Dim employeeID, cmd, errorMessage

errorMessage = ""

If Request.ServerVariables("REQUEST_METHOD") <> "POST" Then
    Response.Status = "405 Method Not Allowed"
    Response.Write "Delete requests must use POST."
    Response.End
End If

employeeID = Trim(Request.Form("EmployeeID"))

If employeeID = "" Or Not IsNumeric(employeeID) Then
    Response.Status = "400 Bad Request"
    Response.Write "Invalid employee ID."
    Response.End
End If

If CDbl(employeeID) < 1 Or CDbl(employeeID) <> Fix(CDbl(employeeID)) Then
    Response.Status = "400 Bad Request"
    Response.Write "Invalid employee ID."
    Response.End
End If

If CDbl(employeeID) > 2147483647 Then
    Response.Status = "400 Bad Request"
    Response.Write "Invalid employee ID."
    Response.End
End If

Set cmd = Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection = conn
cmd.CommandType = adCmdText
cmd.CommandText = "DELETE FROM dbo.Employees WHERE EmployeeID = ?"

cmd.Parameters.Append cmd.CreateParameter( _
    "@EmployeeID", adInteger, adParamInput, , CLng(employeeID))

On Error Resume Next
cmd.Execute

If Err.Number <> 0 Then
    Err.Clear
    On Error GoTo 0

    conn.Close
    Set conn = Nothing

    Response.Status = "500 Internal Server Error"
    Response.Write "The employee could not be deleted. Please try again."
    Response.End
End If

On Error GoTo 0

conn.Close
Set conn = Nothing
Set cmd = Nothing

Response.Redirect "index.asp"
%>
