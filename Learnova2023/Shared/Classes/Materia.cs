namespace Learnova2023.Shared.Classes
{
    public class Materia
    {
        public string Nome { get; set; }
        public int Id { get; set;}

        public Materia() { }
        public Materia(string nome,int id) { 
            this.Nome = nome;
            this.Id = id; 
        }
        
    }
}
