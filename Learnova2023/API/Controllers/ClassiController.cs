using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;

namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class ClassiController : ControllerBase
    {
        [HttpGet]
        public IEnumerable<Classe> GetClassi()
        {
            return ContextClassi.GetClassi();
        }
    }
}
