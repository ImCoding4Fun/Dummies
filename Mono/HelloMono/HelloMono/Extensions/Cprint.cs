using System;
namespace HelloMono.Extensions
{
    public static class Cprint
    {
        public static void Success<T>(T msg)
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine(msg);
        }

        public static void ConsoleSuccess(this string msg) => Success(msg);

        public static void Info<T>(T msg)
        {
            Console.ResetColor();
            Console.WriteLine(msg);
        }

        public static void ConsoleInfo(this string msg) => Info(msg);


        public static void Warning<T>(T msg)
        {
            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine(msg);
        }


        public static void ConsoleWarning(this string msg) => Warning(msg);


        public static void Error<T>(T msg)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine(msg);
        }

        public static void ConsoleError(this string msg) => Error(msg);
        public static void ConsoleFailure(this string msg) => Error(msg);

    }
}
