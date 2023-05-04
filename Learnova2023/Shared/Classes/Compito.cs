﻿namespace Learnova2023.Shared.Classes
{
    public class Compito
    {
        public DateOnly Date { get; set; }
        public string? Tipo { get; set; }
        public Professore? Professore { get; set; }
        public string? Materia { get; set; }
        public string? Descrizione { get; set; }
        public Compito(DateOnly d, string t, Professore p, string m, string des)
        {
            this.Date = d;
            this.Tipo = t;
            this.Professore = p;
            this.Materia = m;
            this.Descrizione = des;
        }
    }
}