using System;
using System.Data.SqlClient;
using System.Net;
using System.Text;
using System.Xml.Linq;

namespace Foo
{
    public sealed class MySingleton
    {
        private MySingleton()
        {
        }

        private static MySingleton _instance;

        //Expression-bodied member
        public static MySingleton Instance => _instance ?? (_instance = new MySingleton());

        //Expression-bodied method
        public override string ToString() => $"Type Name: {GetType().Name}";
    }
    public class SandBox
    {
        static void Main(string[] args)
        {
            int answer = new Random().Next(1,101);
            Console.WriteLine($"My answer is {answer}.");
            Console.WriteLine($"This {(answer == 42? "IS": "ISN'T")} the answer to life universe and everything.");

            Console.WriteLine($"Today is {DateTime.Now:dd-MM-yyyy}");

            MySingleton fstInstance = MySingleton.Instance;
            MySingleton sndInstance = MySingleton.Instance;
            
            Console.WriteLine($"The first instance is named '{nameof(fstInstance)}' whereas the second is named '{nameof(sndInstance)}'");
            Console.WriteLine($"Var Name: '{nameof(fstInstance) + "'\t" + fstInstance.ToString()}");
            Console.WriteLine($"Var Name: '{nameof(sndInstance) + "'\t" + sndInstance.ToString()}");

            var time = Disposable.Using(() => new WebClient(),
                                        client => XDocument.Parse(client.DownloadString("http://www.time.gov/actualtime.cgi")))
                                 .Root
                                 .Attribute("time")
                                 .Value;
            var ms = Convert.ToInt64(time) / 1000;
            var currentTime = new DateTime(1970, 1, 1).AddMilliseconds(ms).ToLocalTime();
            Console.WriteLine($"The current date and time is: { currentTime} ");

            string connectionString = @"Data Source=SQLNCO2-2008-PP\COLLAUDO;Initial Catalog=PlugAndReport;User ID=sa;Password=123456";
            string query = "select top 10 iHistory, chCodDossier, iStato from PR_History";

            var queryResult = Disposable.Using(() => new SqlConnection(connectionString),
                                                client => executeQuery(client, query, new string[]{ "iHistory", "chCodDossier","iStato" }));

            Console.WriteLine($"The query result is:\n{queryResult}");

        }

        private static Func<SqlConnection, string, string[], string> executeQuery = (connection, query, out_params) =>
        {
            StringBuilder result = new StringBuilder("");
            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            try
            {
                while (reader.Read())
                {
                    foreach (var out_param in out_params)
                        result.Append(reader[out_param].ToString() +"\t");
                    result.AppendLine();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.StackTrace);
            }
            finally
            {
                reader.Close();
            }
            return result.ToString().TrimEnd('\n');
        };
    }

    public static class Disposable
    {
        public static TResult Using<TDisposable, TResult>(Func<TDisposable> factory, Func<TDisposable, TResult> map)
        where TDisposable : IDisposable
        {
            using (var disposable = factory())
                return map(disposable);
        }
    }
}
