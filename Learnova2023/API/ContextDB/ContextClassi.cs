using Learnova2023.Shared.Classes;
using Radzen;
using System.Data;
using MySql.Data.MySqlClient;
namespace Learnova2023.API.ContextDB
{
    public class ContextClassi : ContextDB
    {
        public static List<Classe> GetClassi()
        {
            List<Classe> Classi = new List<Classe>();
            string? query = "call Learnova5H.GetClassi();";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    //cmd.CommandType = CommandType.StoredProcedure;
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
    }
}
