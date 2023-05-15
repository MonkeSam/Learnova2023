using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;


namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class AssenzeController : ControllerBase
    {
        [HttpGet(nameof(GetAssenze))]
        public IEnumerable<DateTime> GetAssenze(int idStudente, string sk)
        {
            return ContextAssenze.GetAssenze(idStudente, sk);
        }

        [HttpPost(nameof(CreateAssenza))]
        public void CreateAssenza(int idStudente, DateTime date, string sk)
        {
            ContextAssenze.CreateAssenza(idStudente, date, sk);
        }

        [HttpDelete(nameof(DeleteAssenza))]
        public void DeleteAssenza(int idStudente, DateTime date, string sk)
        {
            ContextAssenze.DeleteAssenza(idStudente, date, sk);
        }
    }

}
