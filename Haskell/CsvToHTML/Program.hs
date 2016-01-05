module Program
where

import Data.String.Utils (replace)
import Data.List (elemIndex)
import Data.Maybe

htmlHead = "<head><style>table {border-collapse: collapse;}table, td, th {border: 1px solid black;}</style></head>"

htmlCell = replace "," "</td><td>"

htmlRow s =  replace "\n" "</td></tr><tr><td>" (htmlCell s)
html s = "<html>"++htmlHead++"<body><table><tr><td>" ++ htmlRow s ++ "</td></tr></table></body></html>"


indent n str
     | n == 0     = str
     | otherwise  = '\t' : indent (n-1) str

indentLn f n str
                | f         = '\n': indent n str
                | otherwise = str

beginTags = ["<html>","<head>","<style>","<body>","<table>","<tr>","<td>"]
endTags = [ "</" ++ tail x | x <- beginTags ]
tags = beginTags ++ endTags

indentLevel x = mod (fromJust $ elemIndex x tags) (length beginTags)

indentHTML x
            | indentLevel x < 3 = indentLevel x
            | otherwise         = indentLevel x -2

replTuple = [ (x,  indentLn (x/="</td>" && x/="<html>") (indentHTML x) x ) | x<-tags ]

prettyHtml s i
       | i==0 =  uncurry replace (head replTuple) s
       | otherwise = prettyHtml (uncurry replace (replTuple!!i) s) (i-1)

--csv_to_pretty_html "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
csvToPrettyHtml csv_file html_file = do
                c <- readFile csv_file
                writeFile html_file $ prettyHtml (html c) (length tags -1)

--compile it:            gch Program.hs
--usage on command line: Program "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
{-
main = do
       args <- getArgs
       putStrLn $ "Input : " ++ head args
       exec <- csvToPrettyHtml (head args) (args!!1)
       putStrLn $ "Output : " ++ (args!!1)
       putStrLn "HTML File generation compled"
-}
