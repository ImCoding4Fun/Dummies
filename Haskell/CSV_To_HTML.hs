import Data.String.Utils (replace)
import Data.List (elemIndex)
import Data.Maybe
import System.Environment (getArgs)

html_head = "<head><style>table {border-collapse: collapse;}table, td, th {border: 1px solid black;}</style></head>"
html_cell s = replace "," "</td><td>" s
html_row s =  replace "\n" "</td></tr><tr><td>" (html_cell s)
html s = "<html>"++html_head++"<body><table><tr><td>" ++ html_row s ++ "</td></tr></table></body></html>"

indent n str
     | n == 0     = str
     | otherwise  = ('\t' : indent (n-1) str)

indentLn f n str
                | f         = '\n': indent n str
                | otherwise = str

begin_tags = ["<html>","<head>","<style>","<body>","<table>","<tr>","<td>"]
end_tags = [ "</" ++ tail x | x <- begin_tags ]
tags = begin_tags ++ end_tags

indentLevel x = mod (fromJust $ elemIndex x tags) (length begin_tags)

indentHTML x
            | indentLevel x < 3 = indentLevel x
            | otherwise         = (indentLevel x) -2

repl_tuple = [ (x,  (indentLn (x/="</td>" && x/="<html>") (indentHTML x) x)) | x<-tags ]

pretty_html s i
       | i==0 = replace (fst(repl_tuple!!0)) (snd(repl_tuple!!0)) s
       | otherwise = pretty_html (replace (fst(repl_tuple!!i)) (snd(repl_tuple!!i)) s) (i-1)

--csv_to_pretty_html "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
csv_to_pretty_html csv_file html_file = do
                c <- readFile csv_file
                writeFile html_file (pretty_html (html c) (length tags -1))

--compile it: gch "source file path"
--usage on command line: CSV_To_HTML "csv file path" "html file path"
main = do
       args <- getArgs
       csv_to_pretty_html (args!!0) (args!!1)