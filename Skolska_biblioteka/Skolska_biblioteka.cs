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

        public int Provera_Korisnika(string email, string lozinka)
        {
            veza.ConnectionString = CS;

            int rezultat;

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
    }
}