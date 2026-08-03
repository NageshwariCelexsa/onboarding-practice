<%
'===========================================
' Feedback Form - Classic ASP
' Self-posting form with XSS protection
'===========================================

Dim requestMethod
Dim username
Dim message

requestMethod = Request.ServerVariables("REQUEST_METHOD")

If requestMethod = "POST" Then
    username = Request.Form("username")
    message = Request.Form("message")
End If
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Form</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            margin:40px;
            background:#f4f4f4;
        }

        .container{
            width:450px;
            margin:auto;
            background:#fff;
            padding:20px;
            border-radius:8px;
            box-shadow:0 0 10px rgba(0,0,0,0.2);
        }

        h2{
            text-align:center;
        }

        label{
            font-weight:bold;
        }

        input[type=text], textarea{
            width:100%;
            padding:10px;
            margin-top:5px;
            margin-bottom:15px;
            box-sizing:border-box;
        }

        textarea{
            resize:vertical;
            height:120px;
        }

        input[type=submit]{
            background:#0078D7;
            color:white;
            border:none;
            padding:10px 20px;
            cursor:pointer;
        }

        input[type=submit]:hover{
            background:#005fa3;
        }

        .result{
            margin-top:25px;
            background:#eaf7ea;
            padding:15px;
            border:1px solid green;
        }
    </style>

</head>
<body>

<div class="container">

    <h2>Feedback Form</h2>

    <!-- Self Posting Form -->
    <form method="POST" action="feedback.asp">

        <label>Name</label>
        <input
            type="text"
            name="username"
            required
            value="<%=Server.HTMLEncode(username)%>">

        <label>Message</label>
        <textarea
            name="message"
            required><%=Server.HTMLEncode(message)%></textarea>

        <input type="submit" value="Submit Feedback">

    </form>

    <%
    If requestMethod = "POST" Then
    %>

        <div class="result">

            <h3>Submitted Feedback</h3>

            <p>
                <strong>Name:</strong>
                <%=Server.HTMLEncode(username)%>
            </p>

            <p>
                <strong>Message:</strong>
                <%=Server.HTMLEncode(message)%>
            </p>

            <p>
                <strong>Server Time:</strong>
                <%=Now()%>
            </p>

        </div>

    <%
    End If
    %>

</div>

</body>
</html>