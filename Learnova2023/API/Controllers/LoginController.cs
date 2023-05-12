using Learnova2023.API.ContextDB;
using Learnova2023.Shared.Classes;
using Microsoft.AspNetCore.Mvc;


namespace Learnova2023.API.Controllers
{
    [Route("api/[Controller]")]
    [ApiController]
    public class LoginController
    {
        [HttpGet(nameof(GetRole))]
        public string[] GetRole(string username, string passwd)
        {
            return ContextDBLogin.Login(username, passwd);
        }
    }
}
