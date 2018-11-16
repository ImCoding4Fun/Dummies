using System;
using HelloMono.Extensions;
using MongoDB.Bson;

namespace HelloMono.Model
{
    public class Rate
    {
        public ObjectId _id { get; set; }
        public string currency { get; set; }

        //Should be decimal, but until 3.4 mongo stores decimal as strings
        public double rate { get; set; }

        public DateTime timestamp { get; set; }
        public string trend { get; set; }

        public override string ToString()
        {
            return $"[{timestamp.GetPrettyElapsedTime()}] 1 EUR = {rate} {currency}. Trend: {trend}";
        }
    }
}
