using Learnova2023.Shared.Classes;
using MySql.Data.MySqlClient;
using System.Data;

namespace Learnova2023.API.ContextDB
{
    public class ContextMaterie:ContextDB
    {
        public static List<Materia> GetMaterie(string? sessionKey)
        {
            List<Materia> Materie = new List<Materia>();
            query = "GetMaterie;";

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
                        Materie.Add(new Materia(){ Nome = Convert.ToString(r[1]), Id = Convert.ToInt32(r[0])});
                    }
                }
            }
            return Materie;
        }
    }
}
