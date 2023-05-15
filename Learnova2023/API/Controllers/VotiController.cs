using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;

namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class VotiController : ControllerBase
    {
        [HttpGet(nameof(GetVotiStudente))]
        public IEnumerable<VotoStudente> GetVotiStudente(int idStud, int idMat, string sk)
        {
            return ContextVoti.GetVotiStudente(idStud, idMat, sk);
        }

        [HttpPost(nameof(CreateVotoStudente))]
        public void CreateVotoStudente(int idStudente, int idMateria, float voto, DateTime date, int idProfessore, string desc, string sk)
        {
            ContextVoti.CreateVotoStudente(idStudente, idMateria,voto, date, idProfessore, desc, sk);
        }

        [HttpPut(nameof(UpdateVotoStudente))]
        public void UpdateVotoStudente(int idStudente, int idMateria, float voto, DateTime date, DateTime dateNew, string desc, string sk)
        {
            ContextVoti.UpdateVotoStudente(idStudente, idMateria, voto, date,dateNew, desc, sk);
        }

        [HttpDelete(nameof(DeleteVotoStudente))]
        public void DeleteVotoStudente(int idStudente, int idMateria, float voto, DateTime date, string sk)
        {
            ContextVoti.DeleteVotoStudente(idStudente, idMateria, voto, date, sk);
        }
    }
}
