using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;

namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class NoteController : ControllerBase
    {
        [HttpGet(nameof(GetNote))]
        public IEnumerable<Nota> GetNote(int idStudente,string sk)
        {
            return ContextNote.GetNote(idStudente,sk);
        }

        [HttpPost(nameof(CreateNote))]
        public void CreateNote(int idStudente,int idProfessore,DateTime date,string descrizione, string sk)
        {
            ContextNote.CreateNote(idStudente, idProfessore, date, descrizione, sk);
        }

        [HttpPut(nameof(UpdateNote))]
        public void UpdateNote(int idStudente, int idProfessore, DateTime date, string descrizione,string sk)
        {
            ContextNote.UpdateNote(idStudente, idProfessore, date, descrizione, sk);
        }

        [HttpDelete(nameof(DeleteNote))]
        public void DeleteNote(int idStudente,int idProfessore,DateTime date, string sk)
        {
            ContextNote.DeleteNote(idStudente, idProfessore, date, sk);
        }
    }
}
