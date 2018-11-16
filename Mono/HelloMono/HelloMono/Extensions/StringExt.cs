using System;
using System.IO;
using System.Linq;

namespace HelloMono.Extensions
{
    public static class StringExt
    {
        /// <summary>
        /// Merges two files.
        /// </summary>
        /// <param name="inPath1">1st file path.</param>
        /// <param name="inPath2">2nd file path.</param>
        /// <param name="outPath">Merged file path.</param>
        public static void MergeFile(this string inPath1, string inPath2, string outPath)
        {
            var mergedText = File.ReadLines(inPath1).Zip(File.ReadLines(inPath2), (l1, l2) => $"{l1}\n{l2}").Aggregate((l1, l2) => l1 + '\n' + l2);
            File.WriteAllText(outPath,mergedText);
        }

        public static void ConsoleTrend(this string message)
        {
            if (message.EndsWith("Trend: Neutral",StringComparison.InvariantCulture))  message.ConsoleInfo();
            if (message.EndsWith("Trend: Positive",StringComparison.InvariantCulture)) message.ConsoleSuccess();
            if (message.EndsWith("Trend: Negative",StringComparison.InvariantCulture)) message.ConsoleFailure();
        }
    }
}