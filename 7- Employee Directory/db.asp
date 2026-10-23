
<%
Dim conn
Set conn = Server.CreateObject("ADODB.Connection")

Dim connectionString
connectionString = "Provider=MSOLEDBSQL;" & _
    "Server=localhost\SQLEXPRESS;" & _
    "Database=InternTraining;" & _
    "Integrated Security=SSPI;" & _
    "Encrypt=Optional;"

conn.Open connectionString
%>
