using Learnova2023.Shared.Classes;
using Radzen;
using System.Data;
using MySql.Data.MySqlClient;

namespace Learnova2023.API.ContextDB
{
    public class ContextCompiti : ContextDB
    {
        public static List<Compito> GetCompiti(int idClasse, string? sessionKey)
        {
            List<Compito> Compiti = new List<Compito>();
            query = "GetCompiti;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {
                        Compiti.Add(new Compito(Convert.ToDateTime(r[0]), Convert.ToString(r[1]), new Professore(Convert.ToString(r[2]), Convert.ToString(r[3])), Convert.ToString(r[4]), Convert.ToString(r[5])));
                    }
                }
            }
            return Compiti;
        }
        public static void CreateCompito(int idClasse, DateTime date, string tipo, int idProfessore, int idMateria, string desc, string? sessionKey)
        {
            query = "CreateCompito";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataOttenimento", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("tipoCompito", tipo).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMateria", idMateria).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("descrizione", desc).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void UpdateCompito(int idClasse, DateTime date, string tipo, int idProfessore, int idMateria, string desc, string? sessionKey)
        {
            query = "UpdateCompito";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataOttenimento", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("tipoCompito", tipo).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMateria", idMateria).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("descrizione", desc).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteCompito(int idClasse, DateTime date, string tipo, int idProfessore, int idMateria, string sessionKey)
        {
            query = "DeleteCompito";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataOttenimento", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("tipoCompito", tipo).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMateria", idMateria).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }

    }
}
