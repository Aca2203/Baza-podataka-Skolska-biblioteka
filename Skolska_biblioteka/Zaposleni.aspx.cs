using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace Skolska_biblioteka
{
    public partial class Zaposleni : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["korisnik"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Skolska_biblioteka.email = Session["korisnik"].ToString();
                Skolska_biblioteka klasa = new Skolska_biblioteka();

                DataTable tabela = klasa.Pozajmica_popuni();
                GridView1.DataSource = tabela;
                GridView1.DataBind();
            }            
        }
    }
}