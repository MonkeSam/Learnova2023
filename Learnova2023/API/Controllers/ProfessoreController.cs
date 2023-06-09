﻿using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;

namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class ProfessoreController : ControllerBase
    {

        [HttpGet(nameof(GetProfessori))]
        public IEnumerable<Professore> GetProfessori(string sk)
        {
            return ContextProfessori.GetProfessori(sk);
        }


        [HttpGet(nameof(GetProfessoreByUsername))]
        public Professore GetProfessoreByUsername(string sk, string username)
        {
            return ContextProfessori.GetProfessoreByUsername(sk, username);
        }


        [HttpPost(nameof(CreateProfessore))]
        public void CreateProfessore(string username, string password, string nome, string cognome, int stipendio, string sk)
        {
            ContextProfessori.CreateProfessore(username, password, nome, cognome, stipendio, sk);
        }

        [HttpPut(nameof(UpdateProfessore))]
        public void UpdateProfessore(string username, string usernameNuovo, string password, string nome, string cognome, int stipendio, string sk)
        {
            ContextProfessori.UpdateProfessore(username, usernameNuovo, password, nome, cognome, stipendio, sk);
        }

        [HttpDelete(nameof(DeleteProfessore))]
        public void DeleteProfessore(int idProf, string sk)
        {
            ContextProfessori.DeleteProfessore(idProf, sk);
        }
        [HttpGet(nameof(GetAssegnazione))]
        public List<Classe> GetAssegnazione(int id,string? sk)
        {
            return ContextProfessori.GetAssegnazione(sk,id);
        }
        [HttpGet(nameof(GetCompetenza))]
        public List<Materia> GetCompetenza(int id, string? sk)
        {
            return ContextProfessori.GetCompetenza(sk, id);
        }
    }
}
