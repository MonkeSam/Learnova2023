using Microsoft.AspNetCore.Mvc;
using Learnova2023.Shared.Classes;
using Learnova2023.API.ContextDB;

namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class ClassiController : ControllerBase
    {
        [HttpGet(nameof(GetClassi))]
        public IEnumerable<Classe> GetClassi(string sk)
        {
            return ContextClassi.GetClassi(sk);
        }

        [HttpPost(nameof(CreateClassi))]
        public void CreateClassi(Classe obj,string sk)
        {
            ContextClassi.CreateClassi(obj, sk);
        }

        [HttpDelete(nameof(DeleteClassi))]
        public void DeleteClassi(int idClasse,string sk)
        {
            ContextClassi.DeleteClassi(idClasse, sk);
        }
    }
}
