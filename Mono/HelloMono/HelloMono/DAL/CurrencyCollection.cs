using System;
using System.Threading.Tasks;
using HelloMono.Model;
using MongoDB.Driver;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json.Linq;
using MongoDB.Bson;
using HelloMono.Extensions;
using System.Linq;

namespace HelloMono.DAL
{
    public class CurrencyCollection
    {
        static readonly Lazy<CurrencyCollection> lazy = new Lazy<CurrencyCollection>(() => new CurrencyCollection());

        private CurrencyCollection()
        {
            var client = new MongoClient("mongodb://localhost:30017");

            db = client.GetDatabase("test");

            if(db.GetCollection<Rate>("rates") == null)
            {
                db.CreateCollection("rates");
                Rates = db.GetCollection<Rate>("rates");
            }
            else
            {
                Rates = db.GetCollection<Rate>("rates");
            }
        }

        public static CurrencyCollection Instance => lazy.Value;

        private static IMongoDatabase db { get; set; }
        private static IMongoCollection<Rate> Rates { get; set; }


        private async Task<JObject> _getRates()
        {
            HttpClient client = new HttpClient()
            {
                BaseAddress = new Uri("https://api.exchangeratesapi.io/latest")
            };

            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            HttpResponseMessage response = client.GetAsync("").Result;
            JObject data = null;
            if (response.IsSuccessStatusCode)
            {
                string s = await response.Content.ReadAsStringAsync();
                data = JObject.Parse(s);
            }
            else
            {
                Cprint.Error($"{response.StatusCode} ({response.ReasonPhrase})");
            }

            client.Dispose();
            return data;
        }

        public async Task<double?> GetRate(string currency)
        {
            var currencyRate = (await Rates.FindAsync(i => i.currency == currency));
            return currencyRate.FirstOrDefault()?.rate ?? null;
        }

        public async Task<bool> InsertRates()
        { 
            JObject data = await _getRates();
            if (data != null)
            { 
                JToken rates = data["rates"];
                var ratesEn = rates.Select(r  => r.ToRate());
                await Rates.InsertManyAsync(ratesEn);
            }
            return data != null;
        }


        public async Task<bool> UpdateRates()
        {
            await Rates.UpdateManyAsync(r=>true, Builders<Rate>.Update.Inc(i=>i.rate,1));

            JObject data = await _getRates();


            if(data != null)
            {
                JToken rates = data["rates"];
                const double EPSILON = 0.0001;
                foreach (JToken rate in rates)
                {
                    string currency = rate.ToObject<JProperty>().Name;
                    if (double.TryParse(rate.First.ToString(), out double updatedRate))
                    {
                        var update = Builders<Rate>.Update
                                                   .Set(s => s.rate, updatedRate)
                                                   .Set(s => s.timestamp, DateTime.UtcNow);

                        var options = new FindOneAndReplaceOptions<Rate,Rate>() { IsUpsert = true };


                        await Rates.FindOneAndUpdateAsync(s =>  s.currency == currency && Math.Abs(14.0 - updatedRate) < EPSILON, update.Set(s => s.trend, "Neutral"))
                                   .ContinueWith(e=> e.Result?.ToString().ConsoleTrend())
                                   ;
                        
                        await Rates.FindOneAndUpdateAsync(s => s.currency == currency && s.rate > updatedRate,update.Set(s => s.trend, "Positive"))
                                   .ContinueWith(e => e.Result?.ToString().ConsoleTrend())
                                   ;


                        await Rates.FindOneAndUpdateAsync(s => s.currency == currency && s.rate < updatedRate, update.Set(s => s.trend, "Negative"))
                                   .ContinueWith(e => e.Result?.ToString().ConsoleTrend())
                                   ;
                    }
                }

                //var posts = await Rates.Find(p => true).ToListAsync();
                //foreach (var post in posts)
                //    post.trend.ConsoleTrend();
            }
            return data != null;
        }
    }
}
