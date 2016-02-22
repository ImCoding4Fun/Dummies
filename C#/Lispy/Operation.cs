using System;

namespace LispyCore
{
    public sealed class Operation
    {
        public const string ADD = "+";
        public const string MIN = "-";
        public const string MULT = "*";
        public const string DIV = "/";
        public const string POW = "^";
        public const string AVG = "avg";
        public string Value { get; private set; }
        public string Error { get; set; }
        public Operation(string value)
        {
            Value = value;
        }
    }
}
