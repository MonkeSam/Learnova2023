
namespace Learnova2023.Shared.Classes
{
    public class Studente : AbsUser, IEquatable<Studente>
    {
        public DateTime DataDiNascita { get; set; }
        public int IdClasse { get; set; }

        public Studente() { }

        public Studente(int id, string nome, string cognome, string user, DateTime data, int idClasse) : base(id, nome, cognome, user)
        {
            this.DataDiNascita = data;
            this.IdClasse = idClasse;
        }

        public bool Equals(Studente? s)
        {
            return this.Id == s.Id;
        }
    }
}
