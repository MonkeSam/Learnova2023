using Learnova2023.Shared.Classes;
using MySql.Data.MySqlClient;
using System.Data;

namespace Learnova2023.API.ContextDB
{
    public class ContextProfessori : ContextDB
    {
        public static List<Professore> GetProfessori(string? sessionKey)
        {
            List<Professore> Professori = new List<Professore>();
            query = "GetProfessori;";

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
                        Professori.Add(new Professore(Convert.ToInt32(r[0]), Convert.ToString(r[1]), Convert.ToString(r[2]), Convert.ToString(r[3]), Convert.ToInt32(r[4])));
                    }
                }
            }
            return Professori;
        }

        public static Professore GetProfessoreByUsername(string? sessionKey, string username)
        {
            Professore Professore = new Professore("", "");
            query = "GetProfessore;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_username", username).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {
                        Professore = new Professore(Convert.ToInt32(r[0]), Convert.ToString(r[1]), Convert.ToString(r[2]), Convert.ToString(r[3]), Convert.ToInt32(r[4]));
                    }
                }
            }
            return Professore;
        }
        public static void CreateProfessore(string username, string password, string nome, string cognome, int stipendio, string? sessionKey)
        {
            query = "CreateProfessore";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("username", username).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("pswd", password).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("nome", nome).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("cognome", cognome).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("stipendio", stipendio).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void UpdateProfessore(string username, string usernameNuovo, string password, string nome, string cognome, int stipendio, string? sessionKey)
        {
            query = "UpdateProfessore";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("username", username).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("nuovoUsername", usernameNuovo).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("pswd", password).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("nomeProf", nome).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("cognomeProf", cognome).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("stipendioProf", stipendio).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteProfessore(int idProfessore, string? sessionKey)
        {
            query = "DeleteProfessore";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idProf", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
    }
}
