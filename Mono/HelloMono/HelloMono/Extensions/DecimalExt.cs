using System;
namespace HelloMono.Extensions
{
    public static class DecimalExt
    {
        public static string ToString(this decimal? d, string currency){
            return d.HasValue ? $"1 EUR = {d} {currency}" : $"Invalid currency {currency}";
        }
    }
}
