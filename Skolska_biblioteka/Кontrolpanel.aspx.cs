using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Skolska_biblioteka
{
    public partial class Кontrolpanel : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            Skolska_biblioteka klasa = new Skolska_biblioteka();

            DataTable tabela = klasa.Grid_administrator_popuni();
            grid_administrator.DataSource = tabela;
            grid_administrator.DataBind();

            tabela = klasa.Grid_zaposleni_popuni();
            grid_zaposleni.DataSource = tabela;
            grid_zaposleni.DataBind();

            tabela = klasa.Grid_clan_popuni();
            grid_clan.DataSource = tabela;
            grid_clan.DataBind();
        }
    }
}