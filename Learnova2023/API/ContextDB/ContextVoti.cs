using Learnova2023.Shared.Classes;
using Radzen;
using System.Data;
using MySql.Data.MySqlClient;
namespace Learnova2023.API.ContextDB
{
    public class ContextVoti : ContextDB
    {
        public static List<VotoStudente> GetVotiStudente(int idStud, int idMat, string? sessionKey)
        {
            List<VotoStudente> Voti = new List<VotoStudente>();
            query = "GetVoti;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("idStud", idStud).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMat", idMat).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {
                        Voti.Add(new VotoStudente(Convert.ToDateTime(r[0]), Convert.ToSingle(r[1]), new Professore(Convert.ToString(r[2]), Convert.ToString(r[3])), Convert.ToString(r[4])));
                    }
                }
            }
            return Voti;
        }
        public static void CreateVotoStudente(int idStudente, int idMateria, float voto, DateTime date, int idProfessore, string desc, string? sessionKey)
        {
            query = "CreateVoto";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMateria", idMateria).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("votoOttenuto", voto).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataOttenimento", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idProfessore", idProfessore).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("descrizione", desc).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void UpdateVotoStudente(int idStudente, int idMateria, float voto, DateTime date,DateTime dateNew, string desc, string? sessionKey)
        {
            query = "UpdateVoto";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMateria", idMateria).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("votoOttenuto", voto).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataOldOttenimento", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataNewOttenimento", dateNew).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("descrizione", desc).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteVotoStudente(int idStudente, int idMateria, float voto, DateTime date,  string? sessionKey)
        {
            query = "DeleteVoto";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStudente", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idMateria", idMateria).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("voto", voto).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataScelta", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
    }
}
