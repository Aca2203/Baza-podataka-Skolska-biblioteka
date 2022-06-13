<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Zaposleni.aspx.cs" Inherits="Skolska_biblioteka.Zaposleni" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Преглед позајмица:</div>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
        <br />
        <label> Имејл адреса члана: 
        <asp:ListBox ID="ListBox2" runat="server" Height="31px" Width="184px"></asp:ListBox>
        </label>
        <br />
        Књига<label>: </label>
        <asp:ListBox ID="ListBox1" runat="server" Height="31px" Width="241px"></asp:ListBox>
        <br />
        Датум узимања<label>: </label>
        <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
        <br />
        Датум враћања<label>: 
        <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
        </label>
        <br />
        <asp:Button ID="btn_unesi" runat="server" Text="Унеси корисника" />
    </form>
</body>
</html>
