using System;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using HelloMono.DAL;
using HelloMono.Extensions;
using HelloMono.Model;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

namespace HelloMono
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            //MainAsync().Wait();

            string connetionString = null;
            SqlConnection cnn;
            connetionString = "Data Source=localhost;Initial Catalog=master;User ID=sa;Password=Osboxes.org";
            cnn = new SqlConnection(connetionString);
            try
            {
                cnn.Open();
                Cprint.Success("Connection Open ! ");
                cnn.Close();
            }
            catch
            {
                Cprint.Error("Can not open connection ! ");
            }       
        }

        static async Task MainAsync()
        {
            //decimal? rate = await CurrencyCollection.Instance.GetRate("GBP");
            //Console.WriteLine(rate.ToString("GBP"));
            await CurrencyCollection.Instance.UpdateRates();

            //await CurrencyCollection.Instance.InsertRates();
        }

    }
}