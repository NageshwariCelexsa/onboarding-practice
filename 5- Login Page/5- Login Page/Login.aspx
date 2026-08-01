<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_5__Login_Page.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:350px; margin:100px auto; padding:20px; border:1px solid #ccc; border-radius:8px;">

        <h2>Login</h2>

        <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
        <br />
        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <br /><br />

        <asp:Label ID="lblPassword" runat="server" Text="Password"></asp:Label>
        <br />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        <br /><br />

        <asp:Button ID="btnLogin" runat="server"
            Text="Login"
            OnClick="btnLogin_Click" />

        <br /><br />

        <asp:Label ID="lblMessage" runat="server" Font-Bold="true"></asp:Label>

    </div>
</form>
</body>
</html>
