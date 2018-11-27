using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Nco2Tools.Model
{
    public class CalculationSet
    {

        public CalculationSet(int id, bool enabled, string name)
        {
            this.Id = id;
            this.Enabled = enabled;
            this.Name = name;
           
            this.Row = new string[2] { this.Id.ToString(), this.Name };
        }


        public int Id { get; internal set; }
        public bool Enabled { get; set; }
        public string Name { get; set; }

        public string[] Row { get; set; }
    }
}
