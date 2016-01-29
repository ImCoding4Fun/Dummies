using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;

namespace Lisp
{
    public static class LispExpression
    {
        private enum ListOp
        {
              ADD = '+'
            , MIN = '-'
            , MULT = '*'
            , DIV = '/'
        }

        private static Func<decimal, decimal, decimal> GetOperation(char oper)
        {
            switch ((ListOp)oper)
            {
                case ListOp.ADD: return (l, r) => l + r;
                case ListOp.MIN: return (l, r) => l - r;
                case ListOp.MULT: return (l, r) => l * r;
                case ListOp.DIV: return (l, r) => l / r;
            }
            throw new NotSupportedException($"The supplied operator '{oper}' is not supported");
        }

        //Nakes the expression trimmming the heading and tailing round braket.
        //e.g. : IN: "(+ 1 1)" OUT: "+ 1 1"  
        private static string toNaked(this string expr) => expr.Trim().Substring(1, expr.Trim().Length - 2);

        //Gets the inner-expression of a given expression.
        //e.g. IN: (+ (+ 3 3) 4) OUT: (+3 3)
        private static string innerExpr(this string expr) => expr.Substring(expr.LastIndexOf('(') + 1, expr.IndexOf(')') - expr.LastIndexOf('(') - 1);

        public static string format(this string expr)
        {
            if (!expr.hasValidSubExpressions())
                return string.Empty;

            string formattedExpr = string.Join(" ", expr.Split(' ').Where(c => c != string.Empty));

            foreach (ListOp op in Enum.GetValues(typeof(ListOp)))
                formattedExpr = string.Join((char)op + " ", formattedExpr.Split((char)op));

            return formattedExpr.Replace("( ", "(").Replace(")", ") ").Replace("  ", " ").Replace(" ) ", ") ").Trim();
        }

        private static bool hasValidChars(this string expr)
        {
            IEnumerable<Char> keywords = ConfigurationManager.AppSettings["keywords"].Split(';').Select(x => x.First());
            return expr.All(c => keywords.Contains(c) || Char.IsDigit(c));
        }

        public static bool hasValidSubExpressions(this string expr)
        {
            if (!expr.hasValidChars())
                return false;

            int openRoundBrakets = expr.Count(c => c == (int)'(');
            int closedRoundBrakets = expr.Count(c => c == (int)')');

            List<Char> opList = new List<Char>();
            foreach (ListOp op in Enum.GetValues(typeof(ListOp)))
                opList.Add((char)op);
           //(+ (*))
            int operators = expr.Count(c => opList.Contains(c));
            return new[] { openRoundBrakets, closedRoundBrakets, operators }.All(v => v == openRoundBrakets);
        } 

        public static decimal Eval(string expr)
        {
            
            string nakedExpr = expr.Contains('(') ? expr.toNaked() : expr;
            if (!nakedExpr.Contains('('))
            {
                string[] elements = nakedExpr.Split(new char[] { ' ' }, 3);
                char oper = elements[0].ToCharArray()[0];
                decimal l = Decimal.Parse(elements[1]);
                decimal r = Decimal.Parse(elements[2]);
                return GetOperation(oper)(l, r);
            }
            else
            {
                string innerExp = expr.innerExpr();
                string evaluatedInnerExp = Eval(innerExp).ToString();

                return Eval(expr.Replace( "(" + innerExp + ")" , evaluatedInnerExp));
            }
        }
        
        public static void Main(string[] args) 
        {
            //Repl
            string expr = "";
            
            while(true)
            {
                Console.Write("user=> ");
                if((expr = Console.ReadLine()).ToLower() == "exit") break;

                string formattedExpr = expr.format();
                if (formattedExpr == string.Empty)
                {
                    Console.WriteLine("Malformed lisp expression.");
                    continue;
                }
                else
                { 
                    Console.WriteLine(formattedExpr);
                    Console.WriteLine(Eval(formattedExpr));
                }
            }
            
            Console.Write("Bye for now!");
        }
    }
}