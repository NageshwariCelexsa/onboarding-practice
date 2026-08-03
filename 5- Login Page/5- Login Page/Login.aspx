<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="Login.aspx.cs"
    Inherits="_5__Login_Page.Login"
    UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Login</title>

    <style>
        body{
            font-family:Arial;
            background:#f4f4f4;
        }

        .login-box{
            width:320px;
            margin:100px auto;
            background:white;
            padding:20px;
            border-radius:6px;
            box-shadow:0 0 10px gray;
        }

        input{
            width:100%;
            padding:8px;
            margin-top:5px;
            margin-bottom:5px;
        }

        .btn{
            width:100%;
            padding:10px;
        }

        .error{
            color:red;
        }

        .success{
            color:green;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="login-box">

<h2>Login</h2>

Username

<asp:TextBox ID="txtUsername" runat="server"> </asp:TextBox>

<asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username required"
CssClass="error" Display="Dynamic"> </asp:RequiredFieldValidator>

<br /><br />

Password

<asp:TextBox
ID="txtPassword"
runat="server"
TextMode="Password">
</asp:TextBox>

<asp:RequiredFieldValidator
ID="rfvPassword"
runat="server"
ControlToValidate="txtPassword"
ErrorMessage="Password required"
CssClass="error"
Display="Dynamic">
</asp:RequiredFieldValidator>

<br /><br />

<asp:Button
ID="btnLogin"
runat="server"
Text="Login"
CssClass="btn"
OnClick="btnLogin_Click" />

<br /><br />

<asp:Label
ID="lblMessage"
runat="server">
</asp:Label>

</div>

</form>

</body>
</html>