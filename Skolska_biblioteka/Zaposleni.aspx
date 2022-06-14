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
            <Columns>
                <asp:TemplateField HeaderText="*">                    
                    <ItemTemplate>
                        <asp:LinkButton ID="Pozajmica_Izmeni" CssClass="link" runat="server" Text="Измени" CommandArgument='<%#Eval("id")%>' OnClick="Pozajmica_Izmeni" />
                    </ItemTemplate>                                        
                </asp:TemplateField>  

                <asp:TemplateField HeaderText="*">
                    <ItemTemplate>
                        <asp:LinkButton ID="Pozajmica_Obrisi" CssClass="link" runat="server" Text="Обриши" CommandArgument='<% #Eval("id")%>' OnClick="Pozajmica_Obrisi" />
                    </ItemTemplate>                                        
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <label> Имејл адреса члана: 
        <asp:ListBox ID="cmb_clan" runat="server" Height="31px" Width="326px" DataTextField="email" DataValueField="email" DataSourceID="SqlDataSource1"></asp:ListBox>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Skolska_bibliotekaConnectionString %>" SelectCommand="select email from korisnik where uloga_id = 1"></asp:SqlDataSource>
        </label>
        <br />
        Књига<label>: </label>
        <asp:ListBox ID="cmb_knjiga" runat="server" Height="31px" Width="412px" DataSourceID="SqlDataSource2" DataTextField="naziv" DataValueField="ISBN"></asp:ListBox>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Skolska_bibliotekaConnectionString %>" SelectCommand="SELECT [ISBN], [naziv] FROM [Knjiga]"></asp:SqlDataSource>
        <br />
        Датум узимања<label>: </label>
        <asp:Calendar ID="datum_uzimanja" runat="server"></asp:Calendar>
        <br />
        Датум враћања<label>: 
        <asp:Calendar ID="datum_vracanja" runat="server"></asp:Calendar>
        <%--<br />--%>
        Враћено:<asp:ListBox ID="cmb_vraceno" runat="server" Height="42px">
            <asp:ListItem>da</asp:ListItem>
            <asp:ListItem>ne</asp:ListItem>
        </asp:ListBox>
        <br />
        </label>
        <br />
        <asp:Button ID="btn_unesi" runat="server" Text="Унеси позајмицу" OnClick="btn_unesi_Click" />
    </form>
</body>
</html>
