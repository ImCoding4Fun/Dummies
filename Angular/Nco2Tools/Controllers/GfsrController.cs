using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Nco2Tools.Model;

namespace Nco2Tools.Controllers
{
    [Route("api/[controller]")]
    public class GfsrController : Controller
    {
        private IConfiguration _configuration;

        public GfsrController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("[action]")]
        public async Task<IEnumerable<CalculationSet>> CalcutationSets()
        {
            List<CalculationSet> calcSets = new List<CalculationSet>();
            string connString = _configuration.GetSection("ConnectionStrings")["GFSR"];
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();

                using (SqlCommand command = new SqlCommand("SELECT cast(0 as bit), CALC_SET FROM CALC_SET", con))
                {
                    SqlDataReader reader = await command.ExecuteReaderAsync();
                    int c = 1;
                    while (reader.Read())
                    {
                        var cs = new CalculationSet(id: c, enabled: reader.GetBoolean(0), name: reader.GetString(1));
                        calcSets.Add(cs);
                        c++;
                    }
                }
            }
            return calcSets;

        }


        [HttpPost("[action]")]
        public async Task<IEnumerable<CalculationSet>> Unit([FromBody]IEnumerable<CalculationSet> calcSets)
        {
            await Task.Delay(0);
            return calcSets;
        }
    }
}