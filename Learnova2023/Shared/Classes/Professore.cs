namespace Learnova2023.Shared.Classes
{
    public class Professore : AbsUser
    {
        public int Stipendio { get; set; }

        public Professore(string n, string c):base(n,c)
        {
            this.Stipendio = 0;
        }

        public Professore(int id,string nome,string cognome,string user,int stipendio):base(id,nome,cognome,user)
        {
            this.Stipendio= stipendio;
        }
    }
}
