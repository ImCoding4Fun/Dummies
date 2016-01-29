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

        private static string outerExpr(this string expr) => expr.Replace(expr.innerExpr(), "#");

        public static string format(this string expr)
        {
            if (!expr.hasValidSubExpressions())
                return string.Empty;

            string formattedExpr = string.Join(" ", expr.Split(' ').Where(c => c != string.Empty));

            foreach (ListOp op in Enum.GetValues(typeof(ListOp)))
                formattedExpr = string.Join((char)op + " ", formattedExpr.Split((char)op));

            formattedExpr = string.Join(" ( ", formattedExpr.Split('('));
            formattedExpr = string.Join(" ) ", formattedExpr.Split(')'));
            
            return formattedExpr;
        }

        private static bool allCharsAreValid(this string expr)
        {
            IEnumerable<Char> keywords = ConfigurationManager.AppSettings["keywords"].Split(';').Select(x => x.First());
            return expr.All(c => keywords.Contains(c) || Char.IsDigit(c));
        }

        private static int nthIndexOf(this string str, char ch, int n) => str.Select((c, i) => i).Where(c => c == ch).Skip(n-1).FirstOrDefault();  

        public static bool hasValidSubExpressions(this string expr)
        {
            if (!expr.allCharsAreValid()) return false;

            int numOfOpenRoundBrakets = expr.Count(c => c == (int)'(');
            int numOfClosedRoundBrakets = expr.Count(c => c == (int)')');

            int openRoundBraketIndexes = expr.nthIndexOf('(',2);

            List<Char> opList = new List<Char>();
            foreach (ListOp op in Enum.GetValues(typeof(ListOp)))
                opList.Add((char)op);
        
            int numOfoperators = expr.Count(c => opList.Contains(c));
            bool allOperatorsHaveEqualCardinality = new[] { numOfOpenRoundBrakets, numOfClosedRoundBrakets, numOfoperators }.All(v => v == numOfOpenRoundBrakets);

            if (!allOperatorsHaveEqualCardinality) return false;

            for (int i = 0; i < numOfOpenRoundBrakets; i++)
                if (expr.nthIndexOf('(', i) > expr.nthIndexOf(')', i)) return false;
            
            return true;
        } 

        public static decimal Eval(string expr)
        {
            string nakedExpr = expr.Contains('(') ? expr.toNaked() : expr;
            if (!nakedExpr.Contains('('))
            {
                string[] elements = nakedExpr.Trim().Replace("  "," ").Split(new char[] { ' ' }, 3);
                char oper = elements[0].ToCharArray()[0];
                decimal l = Decimal.Parse(elements[1]);
                decimal r = Decimal.Parse(elements[2]);
                return GetOperation(oper)(l, r);
            }
            else
            {
                string innerExp = expr.innerExpr();
                string evaluatedInnerExp = Eval(innerExp).ToString();
                string simplifiedExpression = expr.Replace("(" + innerExp + ")", evaluatedInnerExp).Replace("  ", " ").Trim();
                return Eval(simplifiedExpression);
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
                    Console.WriteLine(Eval(formattedExpr));
            }
        }
    }
}