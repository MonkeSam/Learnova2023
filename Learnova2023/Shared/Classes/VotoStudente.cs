namespace Learnova2023.Shared.Classes
{
    public class VotoStudente
    {
        public DateTime Data { get; set; }
        public float Voto { get; set; }

        public Professore Prof { get; set; }

        public string Descrizione { get; set; }

        public VotoStudente(DateTime data,float voto,Professore p,string desc)
        {
            this.Data = data;
            this.Voto = voto;
            this.Prof = p;
            this.Descrizione = desc;

        }
    }
}
