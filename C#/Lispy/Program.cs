using System;
using LispyCore;

namespace LispyREPL
{
    class Program
    {
        static void Main(string[] args)
        {
            bool clear = true;
            string command = "";
            while (true)
            { 
                if(clear)
                {
                    Console.Clear();
                    Console.WriteLine("Lispy REPL");
                    Console.WriteLine("Command list: +, -, *, /, ^, avg");
                    Console.WriteLine("Enter 'cls' to clear screen, 'quit' to exit.");
                    clear = false;
                }

                Console.Write("user=> ");

                command = Console.ReadLine();

                if (command == "quit") break;
                if (command == "cls")
                    clear = true;
                else
                Console.WriteLine(command.Eval());

            }
        }
    }
}
