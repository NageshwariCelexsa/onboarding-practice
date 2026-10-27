
<%
Option Explicit

Dim objConn
Set objConn = Server.CreateObject("ADODB.Connection")

objConn.ConnectionString = _
    "Provider=MSOLEDBSQL;" & _
    "Server=localhost\SQLEXPRESS;" & _
    "Database=InternTraining;" & _
    "Trusted_Connection=Yes;" & _
    "TrustServerCertificate=Yes;"
Response.Write "Connection string: " & _
    Server.HTMLEncode(objConn.ConnectionString)
Response.End
objConn.Open
%>
