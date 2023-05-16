namespace Learnova2023.API.ContextDB
{
    public class ContextStudenti : ContextDB
    {
        public static List<Studente> GetStudenti(int idClasse, string? sessionKey)
        {
            List<Studente> Studenti = new List<Studente>();
            query = "GetStudenti;";

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
                        Studenti.Add(new Studente(Convert.ToInt32(r[0]), Convert.ToString(r[1]), Convert.ToString(r[2]), Convert.ToString(r[3]), Convert.ToDateTime(r[4]), Convert.ToInt32(r[5])));
                    }
                }
            }
            return Studenti;
        }

        public static Studente GetStudenteByUsername(string username, string? sessionKey)
        {
            Studente? Studente = null;
            query = "GetStudente;";

            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.Parameters.AddWithValue("_username", username).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;

                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    adp.Fill(dt);

                    foreach (DataRow r in dt.Rows)
                    {

                        Studente = new Studente(Convert.ToInt32(r[0]), Convert.ToString(r[1]), Convert.ToString(r[2]), Convert.ToString(r[3]), Convert.ToDateTime(r[4]), Convert.ToInt32(r[5]));
                    }
                }
            }
            return Studente;
        }


        public static void CreateStudente(string username, string password, string nome, string cognome, DateTime date, int idClasse, string? sessionKey)
        {
            query = "CreateStudente";
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
                    cmd.Parameters.AddWithValue("dataDiNascita", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void UpdateStudente(string username, string usernameNuovo, string password, string nome, string cognome, DateTime date, int idClasse, string? sessionKey)
        {
            query = "UpdateStudente";
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
                    cmd.Parameters.AddWithValue("nomeStud", nome).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("cognomeStud", cognome).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("dataDiNascitaStud", date).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("idClasse", idClasse).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
        public static void DeleteStudente(int idStudente, string? sessionKey)
        {
            query = "DeleteStudente";
            using (MySqlConnection con = new(ConnectionString))
            {
                using (MySqlCommand cmd = new(query, con))
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("idStud", idStudente).Direction = ParameterDirection.Input;
                    cmd.Parameters.AddWithValue("_sessionKey", sessionKey).Direction = ParameterDirection.Input;
                    MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adp.Fill(dt);
                }
            }
        }
    }
}
