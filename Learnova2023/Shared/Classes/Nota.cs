namespace Learnova2023.Shared.Classes
{
    public class Nota
    {
        public DateTime Date { get; set; }
        public Professore? Professore { get; set; }
        public string? Descrizione { get; set; }

        public Nota(DateTime d, Professore p, string desc)
        {
            this.Date= d;
            this.Professore = p;
            this.Descrizione = desc;
        }
    }
}
