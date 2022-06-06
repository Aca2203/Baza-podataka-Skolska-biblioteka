using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace Skolska_biblioteka
{
    public partial class Кontrolpanel : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["korisnik"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
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

        public void Korisnik_Obrisi(object sender, EventArgs e)
        {
            string email = Convert.ToString((sender as LinkButton).CommandArgument);
            string naredba = "DELETE FROM Korisnik WHERE email = '" + email + "'";

            string CS = ConfigurationManager.ConnectionStrings["Skolska_biblioteka"].ConnectionString;
            SqlConnection veza = new SqlConnection(CS);

            SqlCommand komanda = new SqlCommand(naredba, veza);

            //Response.Write(naredba);

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();

            Response.Redirect("Кontrolpanel.aspx");
        }

        public void Korisnik_Izmeni(object sender, EventArgs e)
        {
            string email = Convert.ToString((sender as LinkButton).CommandArgument);
            Skolska_biblioteka klasa = new Skolska_biblioteka();
            
            int rez = klasa.Korisnik_Update(email, txt_ime.Text, txt_prezime.Text, txt_jmbg.Text, txt_lozinka.Text, cmb_uloga.SelectedIndex);

            Response.Redirect("Кontrolpanel.aspx");
        }        

        protected void btn_unesi_Click(object sender, EventArgs e)
        {
            if (cmb_uloga.SelectedValue == "Празно")
            {
                Response.Write("Изаберите улогу!");
            }
            else
            {
                if (txt_email.Text == "" || txt_lozinka.Text == "" || txt_jmbg.Text == "" || txt_ime.Text == "" || txt_prezime.Text == "")
                {
                    Response.Write("Унесите податке!");
                }
                else
                {
                    Skolska_biblioteka klasa = new Skolska_biblioteka();
                    int rezultat = klasa.Korisnik_Insert(txt_email.Text, txt_lozinka.Text, txt_jmbg.Text, txt_ime.Text, txt_prezime.Text, cmb_uloga.SelectedIndex);

                    if (rezultat == 0)
                    {
                        Response.Redirect("Кontrolpanel.aspx");
                    }
                    else
                    {
                        Response.Write("Корисник већ постоји!");
                    }
                }                
            }            
        }
    }
}