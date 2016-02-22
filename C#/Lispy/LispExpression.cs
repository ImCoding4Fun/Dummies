using System;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace LispyCore
{
    public static class LispExpression
    {
        private static readonly Regex Expression = new Regex(@"^\(([+\-\*\/\^]|avg) [-]{0,1}[0-9]+(\.[0-9]+)?( [-]{0,1}[0-9]+(\.[0-9]*)?)*\)$");
        private static readonly Regex MultiExpression = new Regex(@"^.*(?<innerExpr>\(([+\-\*\/\^]|avg) [-]{0,1}[0-9]+(\.[0-9]+)?( [-]{0,1}[0-9]+(\.[0-9]+)?)*\)).*$");
        
        private static Func<double, double[], double> GetOperation(string oper)
        {
            Operation op = new Operation(oper);

            switch (op.Value)
            {
                case Operation.ADD:  return  (l, r) =>  r.Aggregate(l,(a,b) => a + b);
                case Operation.MIN:  return  (l, r) =>  r.Aggregate(l,(a, b) => a - b);
                case Operation.MULT: return  (l, r) =>  r.Aggregate(l,(a, b) => a * b);
                case Operation.DIV:  return  (l, r) =>  {   op.FailIf(r.Last() == 0D, LispError.DIVIDE_BY_ZERO);
                                                            return r.Aggregate(l, (a, b) => a / b);
                                                        };
                case Operation.POW:  return  (l, r) =>  {
                                                            op.FailIf(r.Count() != 1, LispError.INVALID_ARGS_NUM);
                                                            return Math.Pow(l, r[0]);
                                                        };
                case Operation.AVG:  return  (l, r) =>  {
                                                            op.FailIf(r.Count() == 0, LispError.INVALID_ARGS_NUM);
                                                            return r.Aggregate(l, (a, b) => a + b) / (1 + r.Count());
                                                        };
            }
            return null;
        }

        private static void FailIf(this Operation op, bool condition, string msg)
        {
            op.Error = condition ? msg : string.Empty;
            if (!String.IsNullOrEmpty(op.Error))
            {
                op.Error = "";
                throw new Exception($"Error. Operator '{op.Value}'. {msg}.");
            }
        }

        public static string Eval(this string expr)
        {
            try
            {
                if (Expression.Match(expr).Value == expr)
                    return expr.EvalExpression().ToString(CultureInfo.InvariantCulture);

                if (MultiExpression.IsMatch(expr))
                {
                    foreach (Match match in MultiExpression.Matches(expr))
                        expr = expr.Replace(match.Groups["innerExpr"].Value, match.Groups["innerExpr"].Value.EvalExpression().ToString(CultureInfo.InvariantCulture));
                    return expr.Eval();
                }
            }
            catch (Exception e) { return e.Message; }
          
            return LispError.GENERAL;
        }

        public static double EvalExpression(this string expr)
        {
            int numOfOperators = expr.Count(x=>' '.Equals(x));
            string[] unbracketedExpr = expr.Substring(1, expr.Length - 2).Split(new char[] { ' ' }, numOfOperators+1);
            string oper = unbracketedExpr[0];
            double l = Double.Parse(unbracketedExpr[1], CultureInfo.InvariantCulture);
            double[] r = new double[numOfOperators - 1];

            for (int i = 0; i < numOfOperators - 1; i++)
                r[i] = Double.Parse(unbracketedExpr[i + 2], CultureInfo.InvariantCulture);

            return GetOperation(oper.ToString())(l, r);
        }
    }
}
