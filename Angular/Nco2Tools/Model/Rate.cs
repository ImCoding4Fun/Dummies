using System.Globalization;

namespace Nco2Tools.Model
{
    public class Rate
    {
        public Rate(string currency, decimal exchange)
        {
            this.Currency = currency;
            this.Exchange = exchange;
            this.Row = new string[2] { this.Currency, this.Exchange.ToString(CultureInfo.InvariantCulture) };
        }

        public string Currency { get; set; }
        public decimal Exchange { get; set; }

        public string[] Row { get; set; }

    }
}
