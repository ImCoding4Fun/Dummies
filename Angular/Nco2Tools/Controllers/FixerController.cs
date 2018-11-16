using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Nco2Tools.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace Nco2Tools.Controllers
{
    [Route("api/[controller]")]
    public class FixerController : Controller
    {
        private readonly HttpClient client;
        private IConfiguration _configuration;
        private IMemoryCache _cache;
        public FixerController(IConfiguration configuration,  IMemoryCache memoryCache)
        {
            client = new HttpClient();
            _configuration = configuration;
            _cache = memoryCache;
        }

        [HttpGet("[action]/{baseCurrency}")]
        public async Task<IEnumerable<Rate>> LastExchangeRates(string baseCurrency)
        {
            string cacheKey = $"fixer-cache-{baseCurrency}";
            // Look for cache key.
            if (!_cache.TryGetValue(cacheKey, out IEnumerable<Rate> cacheEntry))
            {
                client.DefaultRequestHeaders.Accept.Clear();

                string srvUrl = _configuration.GetSection("RestAPI")["Exchangerates"];

                string json = await client.GetStringAsync($"{srvUrl}{baseCurrency}");


                JObject data = JObject.Parse(json);

                Rate fRate(JToken jt) => new Rate(currency: jt.Path.Split('.')[1], exchange: jt.ToObject<decimal>());

                cacheEntry = data["rates"].Select(fRate);

                if (int.TryParse(_configuration.GetSection("Cache")["Timeout"], out int timeout))
                {

                    var cacheEntryOptions = new MemoryCacheEntryOptions().SetSlidingExpiration(TimeSpan.FromSeconds(timeout));

                    // Save data in cache.
                    _cache.Set(cacheKey, cacheEntry, cacheEntryOptions);
                }
            }

            return cacheEntry;
        }
    }
}