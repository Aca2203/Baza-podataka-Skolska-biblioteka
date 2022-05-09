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

        public DataTable Grid_administrator_popuni()
        {
            tabela.Reset();
            tabela = new DataTable();

            naredba = "SELECT ime + ' ' + prezime AS 'Име и презиме администратора', jmbg AS 'ЈМБГ', email AS 'Имејл адреса', lozinka AS 'Лозинка' FROM Korisnik WHERE uloga_id = 3";
            
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

            naredba = "SELECT ime + ' ' + prezime AS 'Име и презиме запосленог', jmbg AS 'ЈМБГ', email AS 'Имејл адреса', lozinka AS 'Лозинка' FROM Korisnik WHERE uloga_id = 2";

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

            naredba = "SELECT ime + ' ' + prezime AS 'Име и презиме члана', jmbg AS 'ЈМБГ', email AS 'Имејл адреса', lozinka AS 'Лозинка' FROM Korisnik WHERE uloga_id = 1";

            adapter = new SqlDataAdapter(naredba, veza);

            veza.ConnectionString = CS;
            veza.Open();
            adapter.Fill(tabela);
            veza.Close();

            return tabela;
        }
    }
}