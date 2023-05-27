using Learnova2023.API.ContextDB;
using Learnova2023.Shared.Classes;
using Microsoft.AspNetCore.Mvc;

namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class MateriaController : ControllerBase
    {
        [HttpGet(nameof(GetMaterie))]
        public IEnumerable<Materia> GetMaterie(string sk)
        {
            return ContextMaterie.GetMaterie(sk);
        }
    }
}
