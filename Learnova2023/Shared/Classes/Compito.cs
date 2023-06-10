using System.ComponentModel.DataAnnotations;

namespace Learnova2023.Shared.Classes
{
    public class Compito
    {
        public int Id { get; set; }

        [Required] public DateTime? Date { get; set; }

        [Required] public string? Tipo { get; set; }

        public Professore? Professore { get; set; }
        [Required] public Materia? Materia { get; set; }
        [Required] public string? Descrizione { get; set; }
        public Compito() { }
        public Compito(DateTime d, string t, Professore p, Materia m, string des, int id)
        {

            this.Id = id;
            this.Date = d;
            this.Tipo = t;
            this.Professore = p;
            this.Materia = m;
            this.Descrizione = des;
        }
        public bool Equals(Compito c)
        {


            if (this.Date == c.Date && this.Materia == c.Materia && this.Tipo == c.Tipo && this.Descrizione == c.Descrizione)
            {
                return true;
            }



            return false;
        }


    }
}
