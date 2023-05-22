namespace Learnova2023.Shared.Classes
{
    public class Classe
    {
        public int Id { get; set; }
        public int Anno { get; set; }

        public char Sezione { get; set;}
        public string? Indirizzo { get; set; }

        public Classe(int id,int anno,char sezione,string indirizzo) 
        {
            this.Id = id;
            this.Anno = anno;   
            this.Sezione = sezione;
            this.Indirizzo= indirizzo;
        }
        public string RitornaClasse()
        {
            return $"{Anno} {Sezione}";
        }
        public override string ToString()
        {
            return $"{Anno} {Sezione} {Indirizzo}" ;
        }
    }
}
 