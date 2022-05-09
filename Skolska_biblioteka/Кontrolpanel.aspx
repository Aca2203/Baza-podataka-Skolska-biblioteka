<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Кontrolpanel.aspx.cs" Inherits="Skolska_biblioteka.Кontrolpanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style = "text-align: center">
            Преглед администратора:<br />
            <asp:GridView ID="grid_administrator" runat="server" HorizontalAlign = "Center">
            </asp:GridView>
            <br />
            Преглед запослених:<br />
            <asp:GridView ID="grid_zaposleni" runat="server" HorizontalAlign = "Center">
            </asp:GridView>
            <br />
            Преглед чланова:<br />
            <asp:GridView ID="grid_clan" runat="server" HorizontalAlign = "Center">
            </asp:GridView>
        </div>
    </form>
</body>
</html>
