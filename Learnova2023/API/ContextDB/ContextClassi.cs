using Learnova2023.Shared.Classes;
using Radzen;
using System.Data;
using MySql.Data.MySqlClient;
namespace Learnova2023.API.ContextDB
{
    public class ContextClassi : ContextDB
    {
        public static List<Classe> GetClassi(string? sessionKey)
        {
            List<Classe> Classi = new List<Classe>();
            query = "GetClassi;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {
                        Classi.Add(new Classe(Convert.ToInt32(r[0]), Convert.ToInt32(r[1]), Convert.ToChar(r[2]), Convert.ToString(r[3])));
                    }
                }
            }
            return Classi;
        }
        public static void CreateClassi(Classe obj, string? sessionKey)
        {
            query = "CreateClasse";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("_annoClasse", obj.Anno).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_idSezione", obj.Sezione).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_idIndirizzo", obj.Indirizzo).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteClassi(int idClasse, string sessionKey)
        {
            query = "DeleteClasse";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
    }

}
