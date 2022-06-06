<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Кontrolpanel.aspx.cs" Inherits="Skolska_biblioteka.Кontrolpanel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>    
     
<body>
    <form id="form" runat="server" style = "overflow: hidden">
        <div float = "left">
            Преглед администратора:<br />
            <asp:GridView ID="grid_administrator" runat="server" HorizontalAlign = "Center">
                <Columns>                                      
                
                <asp:TemplateField HeaderText="*">
                    <ItemTemplate>
                        <asp:LinkButton ID="Administrator_Obrisi" CssClass="link" runat="server" Text="Обриши" CommandArgument='<% #Eval("Имејл адреса")%>' OnClick="Korisnik_Obrisi" />
                    </ItemTemplate>                                        
                </asp:TemplateField>

                <asp:TemplateField HeaderText="*">                    
                    <ItemTemplate>
                        <asp:LinkButton ID="Administrator_Izmeni" CssClass="link" runat="server" Text="Измени" CommandArgument='<% #Eval("Имејл адреса")%>' OnClick="Korisnik_Izmeni" />
                    </ItemTemplate>                                        
                </asp:TemplateField>                                                     
                </Columns>
            </asp:GridView>
            <br />
            Преглед запослених:<br />
            <asp:GridView ID="grid_zaposleni" runat="server" HorizontalAlign = "Center">
                <Columns>                    
                <asp:TemplateField HeaderText="*">
                    <ItemTemplate>
                        <asp:LinkButton ID="Zaposleni_Obrisi" CssClass="link" runat="server" Text="Обриши" CommandArgument='<% #Eval("Имејл адреса")%>' OnClick="Korisnik_Obrisi" />
                        </ItemTemplate>
                </asp:TemplateField> 

                <asp:TemplateField HeaderText="*">                    
                    <ItemTemplate>
                        <asp:LinkButton ID="Zaposleni_Izmeni" CssClass="link" runat="server" Text="Измени" CommandArgument='<% #Eval("Имејл адреса")%>' OnClick="Korisnik_Izmeni" />
                    </ItemTemplate>                                        
                </asp:TemplateField> 
                </Columns>
            </asp:GridView>
            <br />
            Преглед чланова:<br />
            <asp:GridView ID="grid_clan" runat="server" HorizontalAlign = "Center">
                <Columns>                                       

                <asp:TemplateField HeaderText="*">
                    <ItemTemplate>
                        <asp:LinkButton ID="Clan_Obrisi" CssClass="link" runat="server" Text="Обриши" CommandArgument='<% #Eval("Имејл адреса")%>' OnClick="Korisnik_Obrisi" />
                        </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="*">                    
                    <ItemTemplate>
                        <asp:LinkButton ID="Clan_Izmeni" CssClass="link" runat="server" Text="Измени" CommandArgument='<% #Eval("Имејл адреса")%>' OnClick="Korisnik_Izmeni" />
                    </ItemTemplate>                                        
                </asp:TemplateField> 
                </Columns>
            </asp:GridView>
        </div>
        <br />  
        <div float = "left">
        <label> Имејл адреса: </label>
        <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>
        <br />
        <label> Лозинка: </label>
        <asp:TextBox ID="txt_lozinka" runat="server"></asp:TextBox>
        <br />
        <label> ЈМБГ: </label>
        <asp:TextBox ID="txt_jmbg" runat="server"></asp:TextBox>
        <br />
        <label> Име: </label>
        <asp:TextBox ID="txt_ime" runat="server"></asp:TextBox>
        <br />
        <label> Презиме: </label>
        <asp:TextBox ID="txt_prezime" runat="server"></asp:TextBox>
        <br />
        <label> Улога: </label>
        <asp:DropDownList ID="cmb_uloga" runat="server">
            <asp:ListItem>Празно</asp:ListItem>
            <asp:ListItem>Члан</asp:ListItem>
            <asp:ListItem>Запослени</asp:ListItem>
            <asp:ListItem>Администратор</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:Button ID="btn_unesi" runat="server" OnClick="btn_unesi_Click" Text="Унеси корисника" />
        </div>
    </form>
</body>
</html>
