namespace Learnova2023
{
    public class StatoApp
    {
        public string Username { get; set; }

        public string SessionString { get; set; }

        public string Role { get; set; }

        public void SetSession(string user, string ss, string role)
        {
            this.Username = user;
            this.SessionString = ss;
            this.Role = role;

        }
    }
}
