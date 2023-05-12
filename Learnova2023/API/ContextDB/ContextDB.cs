using Learnova2023.Shared.Classes;
using MySql.Data.MySqlClient;
using Radzen;
using System.Collections;
using System.Data;

namespace Learnova2023.API.ContextDB
{
    public class ContextDB
    {
        public const string? ConnectionString = "server=10.150.0.123;uid=sa;pwd=burbero2023;database=Learnova5H";

        public static string? query = "";



        public static void Initialize()
        {
            var builder = new ConfigurationBuilder()
                        .SetBasePath(Directory.GetCurrentDirectory())
                        .AddJsonFile("appSettings.json", optional: true, reloadOnChange: true);
            IConfiguration _configuration = builder.Build();
        }



    }
}
