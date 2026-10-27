<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeDirectory.aspx.cs" Inherits="EmployeeDirectory.EmployeeDirectory" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Employee Directory</title>

    <style>

        body{
            font-family:Arial;
            margin:40px;
            background:#f4f4f4;
        }

        .container{
            width:900px;
            margin:auto;
            background:white;
            padding:20px;
            border-radius:8px;
        }

        table{
            width:100%;
        }

        input,select{
            width:100%;
            padding:8px;
            margin-bottom:10px;
        }

        .btn{
            padding:10px 18px;
            cursor:pointer;
            margin-right:5px;
        }

        .grid{
            margin-top:20px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

<h2>Employee Directory</h2>

<asp:HiddenField ID="hfEmployeeID" runat="server" />

<label>Name</label>

<asp:TextBox ID="txtName" runat="server"> </asp:TextBox>

<label>Email</label>

<asp:TextBox ID="txtEmail" runat="server"> </asp:TextBox>

<label>Position</label>

<asp:TextBox ID="txtPosition" runat="server"> </asp:TextBox>

<label>Department</label>

<asp:TextBox ID="txtDepartment" runat="server"> </asp:TextBox>

<label>Hire Date</label>

<asp:TextBox ID="txtHireDate" TextMode="Date" runat="server"> </asp:TextBox>

<br />

<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" OnClick="btnSave_Click"/>

<asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click"/>

<hr />

Search

<asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"> </asp:TextBox>

<div class="grid">

<asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" DataKeyNames="EmployeeID" OnRowEditing="gvEmployees_RowEditing" OnRowDeleting="gvEmployees_RowDeleting">

<Columns>

<asp:BoundField DataField="EmployeeID" HeaderText="ID"/>

<asp:BoundField DataField="FullName" HeaderText="Name"/>

<asp:BoundField DataField="Email" HeaderText="Email"/>

<asp:BoundField DataField="Position" HeaderText="Position"/>

<asp:BoundField DataField="Department" HeaderText="Department"/>

<asp:BoundField DataField="HireDate" HeaderText="Hire Date"/>

<asp:CommandField
ShowEditButton="True"
ShowDeleteButton="True"/>

</Columns>

</asp:GridView>

</div>

</div>

</form>

</body>
</html>