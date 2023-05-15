using Learnova2023.Shared.Classes;
using Radzen;
using System.Data;
using MySql.Data.MySqlClient;

namespace Learnova2023.API.ContextDB
{
    public class ContextAssenze : ContextDB
    {
        public static List<DateTime> GetAssenze(int idStudente, string? sessionKey)
        {
            List<DateTime> Assenze = new List<DateTime>();
            query = "GetAssenze;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("idstudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {
                        Assenze.Add(Convert.ToDateTime(r[0]));
                    }
                }
            }
            return Assenze;
        }
        public static void CreateAssenza(int idStudente, DateTime date, string? sessionKey)
        {
            query = "CreateAssenza";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataAssenza", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteAssenza(int idStudente, DateTime dateScelta, string sessionKey)
        {
            query = "DeleteAssenza";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataScelta", dateScelta).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }

    }
}
