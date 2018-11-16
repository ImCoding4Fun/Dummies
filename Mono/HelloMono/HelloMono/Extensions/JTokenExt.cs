using System;
using HelloMono.Model;
using Newtonsoft.Json.Linq;

namespace HelloMono.Extensions
{
    public static class JTokenExt
    {
        public static Rate ToRate(this JToken jt){
            Rate rate = new Rate();

            rate.currency = jt.ToObject<JProperty>().Name;

            if(double.TryParse(jt.First?.ToString(), out double d))
            {
                rate.rate = d;        
            }

            return rate;
        }
    }
}
