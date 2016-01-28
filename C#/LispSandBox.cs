using System;
using System.Linq;

namespace LispSandBox
{
    public static class LispSandBox
    {
        private enum Op
        {
             ADD  = '+'
            ,MIN  = '-'
            ,MULT = '*'
            ,DIV  = '/'
        }
        private static Func<decimal, decimal, decimal> GetOperation(char oper)
        {
            switch ((Op)oper)
            {
                case Op.ADD:  return (l, r) => l + r;
                case Op.MIN:  return (l, r) => l - r;
                case Op.MULT: return (l, r) => l * r;
                case Op.DIV:  return (l, r) => l / r;
            }
            throw new NotSupportedException($"The supplied operator '{oper}' is not supported");
        }

        //Nakes the expression trimmming the heading and tailing round braket.
        //e.g. : IN: "(+ 1 1)" OUT: "+ 1 1"  
        private static string toNaked(this string expr) => expr.Trim().Substring(1, expr.Trim().Length - 2);
        
        //Gets the inner-expression of a given expression.
        //e.g. IN: (+ (+ 3 3) 4) OUT: (+3 3)
        private static string innerExpr(this string expr) => expr.Substring(expr.LastIndexOf('(') + 1, expr.IndexOf(')') - expr.LastIndexOf('(') - 1);

        private static string format(this string expr) => string.Join(" ", expr.Split(new char[] { ' ' }).Where(c => c != "")).replaceAllOps();

        private static string replaceAllOps(this string expr)
        {
            foreach(Op op in Enum.GetValues(typeof(Op)))
            {
                string oldStr = "( "+(char)op;
                string newStr = oldStr.Replace(" ", "");
                expr = expr.Replace(oldStr, newStr);
            }
           return expr;
        } 

        private static decimal Eval(string expr)
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
            string lispExp = "( * (             * (   / (  +   4 4   ) 4  ) 2) 3 )";
            string formattedExpr = lispExp.format();
            Console.WriteLine($"Original expression: {lispExp}\nFormatted expression: {formattedExpr}\nResult: {Eval(formattedExpr)}");
        }
    }
}
