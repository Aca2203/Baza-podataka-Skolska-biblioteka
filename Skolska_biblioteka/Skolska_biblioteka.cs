using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Skolska_biblioteka
{
    public class Skolska_biblioteka
    {
        SqlConnection veza = new SqlConnection();
        string CS = ConfigurationManager.ConnectionStrings["Skolska_biblioteka"].ConnectionString;
        SqlCommand komanda = new SqlCommand();
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet set = new DataSet();
        string naredba;
        DataTable tabela = new DataTable();
        static public string email;

        public int Provera_Korisnika(string email, string lozinka)
        {
            veza.ConnectionString = CS;

            int rezultat = 0;

            komanda.Connection = veza;
            komanda.CommandType = CommandType.StoredProcedure;
            komanda.CommandText = "Uloguj_se";

            komanda.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, email));
            komanda.Parameters.Add(new SqlParameter("@lozinka", SqlDbType.VarChar, 30, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, lozinka));
            komanda.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null));

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();

            int ret;
            ret = (int) komanda.Parameters["@RETURN_VALUE"].Value;            
            if (ret == 1)
            {
                rezultat = 1;
            }
            if (ret == 2)
            {
                rezultat = 2;
            }
            if (ret == 3)
            {
                rezultat = 3;
            }
            if (ret == -1)
            {
                rezultat = -1;
            }

            return rezultat;
        }

        public int Korisnik_Insert(string email, string lozinka, string jmbg, string ime, string prezime, int uloga_id)
        {
            veza.ConnectionString = CS;

            int rezultat = 0;

            komanda.Connection = veza;
            komanda.CommandType = CommandType.StoredProcedure;
            komanda.CommandText = "Korisnik_Insert";

            komanda.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, email));
            komanda.Parameters.Add(new SqlParameter("@lozinka", SqlDbType.VarChar, 30, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, lozinka));
            komanda.Parameters.Add(new SqlParameter("@jmbg", SqlDbType.Char, 17, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, jmbg));
            komanda.Parameters.Add(new SqlParameter("@ime", SqlDbType.VarChar, 20, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, ime));
            komanda.Parameters.Add(new SqlParameter("@prezime", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, prezime));
            komanda.Parameters.Add(new SqlParameter("@uloga_id", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, uloga_id));
            komanda.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null));

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();

            int ret;
            ret = (int) komanda.Parameters["@RETURN_VALUE"].Value;
            if (ret == 0)
            {
                rezultat = 0;
            }
            else
            {
                rezultat = 1;
            }

            return rezultat;
        }

        public int Korisnik_Update(string email, string ime, string prezime, string jmbg, string lozinka, int uloga_id)
        {
            veza.ConnectionString = CS;

            int rezultat = 0;

            komanda.Connection = veza;
            komanda.CommandType = CommandType.StoredProcedure;
            komanda.CommandText = "Korisnik_Update";

            komanda.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, email));
            komanda.Parameters.Add(new SqlParameter("@lozinka", SqlDbType.VarChar, 30, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, lozinka));
            komanda.Parameters.Add(new SqlParameter("@jmbg", SqlDbType.Char, 17, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, jmbg));
            komanda.Parameters.Add(new SqlParameter("@ime", SqlDbType.VarChar, 20, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, ime));
            komanda.Parameters.Add(new SqlParameter("@prezime", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, prezime));
            komanda.Parameters.Add(new SqlParameter("@uloga_id", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, uloga_id));
            komanda.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null));

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();

            int ret;
            ret = (int) komanda.Parameters["@RETURN_VALUE"].Value;
            if (ret == 0)
            {
                rezultat = 0;
            }
            else
            {
                rezultat = -1;
            }

            return rezultat;
        }

        public DataTable Grid_administrator_popuni()
        {
            tabela.Reset();
            tabela = new DataTable();

            naredba = "SELECT ime + ' ' + prezime AS 'Име и презиме', jmbg AS 'ЈМБГ', email AS 'Имејл адреса', lozinka AS 'Лозинка' FROM Korisnik WHERE uloga_id = 3";

            adapter = new SqlDataAdapter(naredba, veza);

            veza.ConnectionString = CS;
            veza.Open();
            adapter.Fill(tabela);
            veza.Close();

            return tabela;
        }

        public DataTable Grid_zaposleni_popuni()
        {
            tabela.Reset();
            tabela = new DataTable();

            naredba = "SELECT ime + ' ' + prezime AS 'Име и презиме', jmbg AS 'ЈМБГ', email AS 'Имејл адреса', lozinka AS 'Лозинка' FROM Korisnik WHERE uloga_id = 2";

            adapter = new SqlDataAdapter(naredba, veza);

            veza.ConnectionString = CS;
            veza.Open();
            adapter.Fill(tabela);
            veza.Close();

            return tabela;
        }

        public DataTable Grid_clan_popuni()
        {
            tabela.Reset();
            tabela = new DataTable();

            naredba = "SELECT ime + ' ' + prezime AS 'Име и презиме', jmbg AS 'ЈМБГ', email AS 'Имејл адреса', lozinka AS 'Лозинка' FROM Korisnik WHERE uloga_id = 1";

            adapter = new SqlDataAdapter(naredba, veza);

            veza.ConnectionString = CS;
            veza.Open();
            adapter.Fill(tabela);
            veza.Close();

            return tabela;
        }

        public DataTable Combo_uloga_popuni()
        {
            tabela.Reset();
            tabela = new DataTable();

            naredba = "SELECT id, naziv FROM Uloga";

            adapter = new SqlDataAdapter(naredba, veza);

            veza.ConnectionString = CS;
            veza.Open();
            adapter.Fill(tabela);
            veza.Close();

            return tabela;
        }

        public DataTable Pozajmica_popuni()
        {
            tabela.Reset();
            tabela = new DataTable();

            naredba = "SELECT id, datum_uzimanja, datum_vracanja, clan_email, Knjiga.naziv, vraceno FROM Pozajmica JOIN Knjiga ON Knjiga.ISBN = Pozajmica.knjiga_ISBN WHERE zaposleni_email = '" + email + "' ORDER BY vraceno DESC";

            adapter = new SqlDataAdapter(naredba, veza);

            veza.ConnectionString = CS;
            veza.Open();
            adapter.Fill(tabela);
            veza.Close();

            return tabela;
        }

        public int Pozajmica_Insert(DateTime datum_uzimanja, DateTime datum_vracanja, string clan_email, string zaposleni_email, string knjiga_ISBN)
        {
            veza.ConnectionString = CS;            

            komanda.Connection = veza;
            komanda.CommandType = CommandType.StoredProcedure;
            komanda.CommandText = "Pozajmica_Insert";

            komanda.Parameters.Add(new SqlParameter("@datum_uzimanja", SqlDbType.DateTime, 100, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, datum_uzimanja));
            komanda.Parameters.Add(new SqlParameter("@datum_vracanja", SqlDbType.DateTime, 100, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, datum_vracanja));
            komanda.Parameters.Add(new SqlParameter("@clan_email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, clan_email));
            komanda.Parameters.Add(new SqlParameter("@zaposleni_email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, zaposleni_email));
            komanda.Parameters.Add(new SqlParameter("@knjiga_ISBN", SqlDbType.Char, 17, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, knjiga_ISBN));
            komanda.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null));

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();

            int ret;
            ret = (int) komanda.Parameters["@RETURN_VALUE"].Value;            

            return ret;
        }

        public int Pozajmica_Update(int id, DateTime datum_uzimanja, DateTime datum_vracanja, string vraceno, string clan_email, string zaposleni_email, string knjiga_ISBN)
        {
            veza.ConnectionString = CS;

            komanda.Connection = veza;
            komanda.CommandType = CommandType.StoredProcedure;
            komanda.CommandText = "Pozajmica_Update";

            komanda.Parameters.Add(new SqlParameter("@id", SqlDbType.Int, 4, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, id));
            komanda.Parameters.Add(new SqlParameter("@datum_uzimanja", SqlDbType.DateTime, 100, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, datum_uzimanja));
            komanda.Parameters.Add(new SqlParameter("@datum_vracanja", SqlDbType.DateTime, 100, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, datum_vracanja));
            komanda.Parameters.Add(new SqlParameter("@vraceno", SqlDbType.Char, 2, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, vraceno));
            komanda.Parameters.Add(new SqlParameter("@clan_email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, clan_email));
            komanda.Parameters.Add(new SqlParameter("@zaposleni_email", SqlDbType.VarChar, 50, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, zaposleni_email));
            komanda.Parameters.Add(new SqlParameter("@knjiga_ISBN", SqlDbType.Char, 17, ParameterDirection.Input, false, 0, 0, "", DataRowVersion.Current, knjiga_ISBN));
            komanda.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int, 4, ParameterDirection.ReturnValue, true, 0, 0, "", DataRowVersion.Current, null));

            veza.Open();
            komanda.ExecuteNonQuery();
            veza.Close();

            int ret;
            ret = (int)komanda.Parameters["@RETURN_VALUE"].Value;

            return ret;
        }
    }
}