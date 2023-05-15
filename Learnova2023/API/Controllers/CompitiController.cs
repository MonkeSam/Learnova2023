using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;
namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class CompitiController : ControllerBase
    {
        [HttpGet(nameof(GetCompiti))]
        public IEnumerable<Compito> GetCompiti(int idClasse, string sk)
        {
            return ContextCompiti.GetCompiti(idClasse, sk);
        }

        [HttpPost(nameof(CreateCompito))]
        public void CreateCompito(int idClasse, DateTime date, string tipo, int idProfessore, int idMateria, string desc, string sk)
        {
            ContextCompiti.CreateCompito(idClasse, date, tipo, idProfessore, idMateria, desc, sk);
        }

        [HttpPut(nameof(UpdateCompito))]
        public void UpdateCompito(int idClasse, DateTime date, string tipo, int idProfessore, int idMateria, string desc, string sk)
        {
            ContextCompiti.UpdateCompito(idClasse, date, tipo, idProfessore, idMateria, desc, sk);
        }

        [HttpDelete(nameof(DeleteCompito))]
        public void DeleteCompito(int idClasse, DateTime date, string tipo, int idProfessore, int idMateria, string sk)
        {
            ContextCompiti.DeleteCompito(idClasse, date, tipo, idProfessore, idMateria, sk);
        }
    }
}
