using Microsoft.VisualStudio.TestTools.UnitTesting;
using Lisp;
namespace LispTest
{
    [TestClass]
    public class EvalLispExpressionsUnitTest
    {
        [TestMethod]
        public void EvalWellFormattedGrade1()
        {
            decimal result = LispExpression.Eval("(+ 1 1)");
            Assert.IsTrue(result == 2);
        }

        [TestMethod]
        public void EvalWellFormattedGrade2()
        {
            decimal result = LispExpression.Eval("(* (+ 1 1) 2)");
            Assert.IsTrue(result == 4);
        }

        [TestMethod]
        public void EvalWellFormattedGrade3()
        {
            decimal result = LispExpression.Eval("(/ (* (+ 1 1) 2) 4)");
            Assert.IsTrue(result == 1);
        }

        [TestMethod]
        public void EvalWellFormattedGrade4()
        {
            decimal result = LispExpression.Eval("(- (/ (* (+ 1 1) 2) 4) 5)");
            Assert.IsTrue(result == -4);
        }
        
        [TestMethod]
        public void EvalBadFormattedGrade2()
        {
            string formattedExpr = "(- (* 3 3)9)".format();
            decimal result = LispExpression.Eval(formattedExpr);
            Assert.IsTrue(result == 0);
        }
        
        [TestMethod]
        public void EvalBadFormattedGrade4()
        {
            string formattedExpr = " (  * (   * (-(+     4 4 ) 4) 2   )   3   ) ".format();
            decimal result = LispExpression.Eval(formattedExpr);
            Assert.IsTrue(result == 24);
        }

        [TestMethod]
        public void EvalBadFormattedGrade4_1()
        {
            string formattedExpr = "(*(*(-(+4 4)4)2)3   ) ".format();
            decimal result = LispExpression.Eval(formattedExpr);
            Assert.IsTrue(result == 24);
        }

        [TestMethod]
        public void EvalWellFormattedGrade2Left()
        {
            string formattedExpr = "(* 2 (+ 1 1) )".format();
            decimal result = LispExpression.Eval(formattedExpr);
            Assert.IsTrue(result == 4);
        }

        [TestMethod]
        public void EvalBadFormattedGrade2Left()
        {
            string formattedExpr = "(*2(+ 1 1) )".format();
            decimal result = LispExpression.Eval(formattedExpr);
            Assert.IsTrue(result == 4);
        }

        [TestMethod]
        public void FixMe()
        {
            string formattedExpr = "(+ (* 4 4) (- 3 3))".format();
            decimal result = LispExpression.Eval(formattedExpr);
            Assert.IsTrue(result == 4);
        }
        
    }
}
