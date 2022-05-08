using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Skolska_biblioteka
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            Skolska_biblioteka klasa = new Skolska_biblioteka();
            int rezultat;
            rezultat = klasa.Provera_Korisnika(txt_email.Text, txt_lozinka.Text);

            if (rezultat == 0)
            {
                Session["korisnik"] = txt_email.Text;
                Response.Redirect("kontrolpanel.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}