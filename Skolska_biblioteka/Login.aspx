<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Skolska_biblioteka.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Улогуј се!</div>
        Имејл адреса:
        <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>
        <br />
        Лозинка: <asp:TextBox ID="txt_lozinka" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="btn_login" runat="server" OnClick="btn_login_Click" Text="Улогуј се" />
    </form>
</body>
</html>
