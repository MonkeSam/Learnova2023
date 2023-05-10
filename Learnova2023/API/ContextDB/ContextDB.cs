using Learnova2023.Shared.Classes;
using MySql.Data.MySqlClient;
using Radzen;
using System.Collections;
using System.Data;

namespace Learnova2023.API.ContextDB
{
    public class ContextDB
    {
        public const string? ConnectionString = "server=10.150.0.123;uid=sa;pwd=burbero2023;database=Learnova5H";

        public enum UserType
        {
            not_Found = 0, Studente = 1, Professore = 2, Admin = 3

        }

        public static void Initialize()
        {
            var builder = new ConfigurationBuilder()
                        .SetBasePath(Directory.GetCurrentDirectory())
                        .AddJsonFile("appSettings.json", optional: true, reloadOnChange: true);
            IConfiguration _configuration = builder.Build();
        }
        public static string Login(string username, string paswd)
        {
            string query = $"call Learnova5H.Login(@username, @paswd,@isCheck1, @isCheck2)";

            bool[] type;
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.Parameters.AddWithValue("@username", username).Direction = ParameterDirection.Input;
                    //cmd.Parameters["username"]
                    cmd.Parameters.AddWithValue("@paswd", paswd).Direction = ParameterDirection.Input;

                    cmd.Parameters.AddWithValue("@isCheck1", MySqlDbType.Bit).Direction = ParameterDirection.Output;

                    cmd.Parameters.AddWithValue("@isCheck2", MySqlDbType.Bit).Direction = ParameterDirection.Output;

                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    //cmd.CommandType = CommandType.StoredProcedure;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    type = new bool[] { Convert.ToBoolean(dt.Rows[0][0]), Convert.ToBoolean(dt.Rows[0][1]) };

                    UserType tipo = UserType.not_Found;



                    if (type[0] == false)
                    {

                        if (type[1] == true)
                        {
                            //l'utente è uno studente
                            tipo = UserType.Studente;
                        }
                    }
                    else
                    {
                        if (type[1] == false)
                        {
                            //l'utente è un professore
                            tipo = UserType.Professore;
                        }
                        else
                        {
                            //l'utente è un admin
                            tipo = UserType.Admin;
                        }

                    }
                    return Enum.GetName(tipo);
                }
            }
        }
    }
}
