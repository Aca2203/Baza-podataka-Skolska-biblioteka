using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

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

        protected void btn_unesi_Click(object sender, EventArgs e)
        {
            Skolska_biblioteka klasa = new Skolska_biblioteka();
            int ret = klasa.Pozajmica_Insert(datum_uzimanja.SelectedDate, datum_vracanja.SelectedDate, cmb_clan.SelectedValue, Skolska_biblioteka.email, cmb_knjiga.SelectedValue);

            //Response.Write(datum_uzimanja.SelectedDate + " " + datum_vracanja.SelectedDate + " " + cmb_clan.SelectedValue + " " + Skolska_biblioteka.email + " " + cmb_knjiga.SelectedValue);

            Response.Write(ret);
        }

        public void Pozajmica_Izmeni(object sender, EventArgs e)
        {
            int id = Convert.ToInt32((sender as LinkButton).CommandArgument);
            Skolska_biblioteka klasa = new Skolska_biblioteka();

            int rez = klasa.Pozajmica_Update(id, datum_uzimanja.SelectedDate, datum_vracanja.SelectedDate, cmb_vraceno.SelectedValue, cmb_clan.SelectedValue, Skolska_biblioteka.email, cmb_knjiga.SelectedValue);

            Response.Redirect("Zaposleni.aspx");
        }

        public void Pozajmica_Obrisi(object sender, EventArgs e)
        {
            int id = Convert.ToInt32((sender as LinkButton).CommandArgument);
            string naredba = "DELETE FROM Pozajmica WHERE id = " + id;

            string CS = ConfigurationManager.ConnectionStrings["Skolska_biblioteka"].ConnectionString;
            SqlConnection veza = new SqlConnection(CS);

            SqlCommand komanda = new SqlCommand(naredba, veza);

            //Response.Write(naredba);

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();            

            Response.Redirect("Zaposleni.aspx");
        }
    }
}