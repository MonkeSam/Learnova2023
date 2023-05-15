namespace Learnova2023.Shared.Classes
{
    public class Studente:AbsUser
    {
        public DateTime DataDiNascita { get; set; }
        public int  idClasse { get; set; }
        public Studente(int id, string nome, string cognome, string user, DateTime data, int idClasse):base(id,nome,cognome,user) 
        {
            this.DataDiNascita = data;
            this.idClasse = idClasse;
        }
    }
}
