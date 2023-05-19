namespace Learnova2023.Shared.Classes
{
    public class Professore : AbsUser, IEquatable<Professore>
    {
        public int Stipendio { get; set; }

        public Professore() { }

        public Professore(string n, string c) : base(n, c)
        {
            this.Nome = n;
            this.Cognome = c;
            this.Stipendio = 0;
            this.User = null;
            this.Id = 0;
        }

        public Professore(int id, string nome, string cognome, string user, int stipendio) : base(id, nome, cognome, user)
        {
            this.Stipendio = stipendio;
        }
        public override string ToString()
        {
            return $"{this.Nome} {this.Cognome}";
        }

        public bool Equals(Professore? p)
        {
            return this.Id == p.Id;
        }
    }
}
