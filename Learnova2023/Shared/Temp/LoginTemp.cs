using System.ComponentModel.DataAnnotations;

namespace Learnova2023.Shared.Temp
{
    public class LoginTemp
    {
        [Required]
        [StringLength(16, ErrorMessage = "Username inserito troppo lungo.\nLunghezza massima 16 caratteri")]
        public string? Username { get; set; }
        public string? Password { get; set; }

        public LoginTemp(string u, string p)
        {
            this.Username = u;
            this.Password = p;
        }
    }
}
