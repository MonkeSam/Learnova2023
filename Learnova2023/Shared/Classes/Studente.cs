namespace Learnova2023.Shared.Classes
{
    public class Studente:AbsUser
    {
        public DateOnly DataDiNascita { get; set; }
        public Classe?  Classe { get; set; }
        public Studente(int id, string nome, string cognome, string user, DateOnly data, Classe classe):base(id,nome,cognome,user) 
        {
            this.DataDiNascita = data;
            this.Classe = classe;
        }
    }
}
