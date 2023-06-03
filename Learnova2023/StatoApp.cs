namespace Learnova2023
{
    public class StatoApp
    {
        public string? Username { get; set; }

        public string? SessionString { get; set; }

        public dynamic? Details { get; set; }

        public int  idClasse { get; set; }


        public void SetSession(string user, string ss, dynamic d)
        {
            this.Username = user;
            this.SessionString = ss;
            this.Details = d;
        }

        public void Reset()
        {
            this.Username= null;
            this.SessionString = null;
            this.Details = null;
            this.idClasse = 0;

        }
    }
}
