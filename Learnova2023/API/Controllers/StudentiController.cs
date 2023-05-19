using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;
namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class StudentiController : ControllerBase
    {
        [HttpGet(nameof(GetStudenti))]
        public IEnumerable<Studente> GetStudenti(int idClasse,string sk)
        {
            return ContextStudenti.GetStudenti(idClasse,sk);
        }

        [HttpPost(nameof(CreateStudente))]
        public void CreateStudente(string username, string password, string nome, string cognome, DateTime date,int idClasse, string sk)
        {
            ContextStudenti.CreateStudente(username, password, nome, cognome, date, idClasse, sk);
        }

        [HttpPut(nameof(UpdateStudente))]
        public void UpdateStudente(string username, string usernameNuovo, string password, string nome, string cognome, DateTime date ,int idClasse, string sk)
        {
            ContextStudenti.UpdateStudente(username, usernameNuovo, password, nome, cognome, date, idClasse, sk);
        }

        [HttpDelete(nameof(DeleteStudente))]
        public void DeleteStudente(int idStud, string sk)
        {
            ContextStudenti.DeleteStudente(idStud, sk);
        }

    }
}
