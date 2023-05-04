namespace Learnova2023.Shared.Classes
{
    public abstract class AbsUser
    {
        public int Id { get; set; }

        public string?  Nome { get; set; }
        public string? Cognome { get; set; }
        public string? User { get; set; }

        public AbsUser(string n, string c)
        {
            this.Id = 0;
            this.Nome = n;
            this.Cognome = c;
            this.User = null;
        }

        public AbsUser(int id,string n,string c,string u)
        {
            this.Id = id;
            this.Nome = n;
            this.Cognome = c;
            this.User = u;
        }
    }
}
