{-
 (Almost) purely sandbox file
-}
import Data.String.Utils (replace)
import Data.List (elemIndex)
import Data.Maybe

html_head = "<head><style>table {border-collapse: collapse;}table, td, th {border: 1px solid black;}</style></head>"
html_cell s = replace "," "</td><td>" s
html_row s =  replace "\n" "</td></tr><tr><td>" (html_cell s)
html s = "<html>"++html_head++"<body><table><tr><td>" ++ html_row s ++ "</td></tr></table></body></html>"

--csv_to_html "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
csv_to_html csv_file html_file = do
                c <- readFile csv_file
                writeFile html_file (html c)

indent n str
     | n == 0     = str
     | otherwise  = ('\t' : indent (n-1) str)

indentLn n str = '\n': indent n str

begin_source = ["<head>","<style>","<body>","<table>","<tr>","<td>"]
end_source = [ "</" ++ tail x | x <- begin_source ]

source = begin_source ++ end_source
max_indent = length begin_source
dest = zipWith (\x y -> indentLn x y ) ([1.. max_indent]++[1.. max_indent]) source

pretty_html s i
         | i == 0 = replace (source!!0) (dest!!0) s
         | otherwise = pretty_html (replace (source!!i) (dest!!i) s) (i-1)
        
--csv_to_pretty_html "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
csv_to_pretty_html csv_file html_file = do
                c <- readFile csv_file
                writeFile html_file (p_h (html c) (length source))

s = [ (x, fromJust $ elemIndex x begin_source) | x <- begin_source ]
d = [ ("</" ++ tail (fst x),snd x) | x<-s ]

b_tags = ["<html>","<head>","<style>","<body>","<table>","<tr>","<td>"]
e_tags = [ "</" ++ tail x | x <- b_tags ]
tags = b_tags ++ e_tags

indentLevel x = mod (fromJust $ elemIndex x tags) (length b_tags)

indentHTML x
            | indentLevel x < 3 = indentLevel x
            | otherwise         = (indentLevel x) -2

r = [ (x,  indentLn (indentHTML x) x) | x<-tags ]

p_h s i
       | i==0 = replace (fst(r!!0)) (snd(r!!0)) s
       | otherwise = p_h (replace (fst(r!!i)) (snd(r!!i)) s) (i-1)