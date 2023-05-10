namespace Learnova2023.Shared.Temp
{
    public class LoginTemp
    {
        public string? Username { get; set; }
        public string? Password { get; set; }

        public LoginTemp(string u, string p)
        {
            this.Username = u;
            this.Password = p;
        }
    }
}
