using Learnova2023.Shared.Classes;
using Radzen;
using System.Data;
using MySql.Data.MySqlClient;

namespace Learnova2023.API.ContextDB
{
    public class ContextNote : ContextDB
    {
        public static List<Nota> GetNote(int idStudente,string? sessionKey)
        {
            List<Nota> Note = new List<Nota>();
            query = "GetNote;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {
                        Note.Add(new Nota(Convert.ToDateTime(r[0]), new Professore(Convert.ToString(r[1]), Convert.ToString(r[2])), Convert.ToString(r[3])));
                    }
                }
            }
            return Note;
        }
        public static void CreateNote(int idStudente,int idProfessore, DateTime date, string desc, string? sessionKey)
        {
            query = "CreateNota";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataProvvedimento", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("descrizione", desc).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void UpdateNote(int idStudente,int idProfessore,DateTime dateProv,string desc,string? sessionKey)
        {
            query = "UpdateNota";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataProvvedimento", dateProv).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("descrizione", desc).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteNote(int idStudente,int idProfessore,DateTime dateScelta, string sessionKey)
        {
            query = "DeleteNota";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
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
