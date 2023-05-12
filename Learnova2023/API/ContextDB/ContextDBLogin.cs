using MySql.Data.MySqlClient;
using static Learnova2023.API.ContextDB.ContextDB;
using System.Data;

namespace Learnova2023.API.ContextDB
{
    public class ContextDBLogin : ContextDB
    {
        public enum UserType
        {
            not_Found = 0, Studente = 1, Professore = 2, Admin = 3

        }
        public static string[] Login(string username, string paswd)
        {
            query = $"Learnova5H.Login";

            bool[] type;
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("_username", username).Direction = ParameterDirection.Input;
                    //cmd.Parameters["username"]
                    cmd.Parameters.AddWithValue("_pswd", paswd).Direction = ParameterDirection.Input;




                    cmd.Parameters.Add("_isCheck1", MySqlDbType.Bit).Direction = ParameterDirection.Output;


                    cmd.Parameters.Add("_isCheck2", MySqlDbType.Bit).Direction = ParameterDirection.Output;


                    cmd.Parameters.Add("_sessionkey", MySqlDbType.VarChar).Direction = ParameterDirection.Output;


                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    //cmd.CommandType = CommandType.StoredProcedure;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    type = new bool[] { Convert.ToBoolean(cmd.Parameters["_isCheck1"].Value), Convert.ToBoolean(cmd.Parameters["_isCheck2"].Value) };
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
                    return new string[] { Enum.GetName(tipo), Convert.ToString(cmd.Parameters["_sessionkey"].Value) };
                }
            }
        }

    }
}
