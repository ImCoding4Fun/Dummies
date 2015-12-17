import Data.String.Utils (replace)
import Data.List (isInfixOf)
charFound c [] = False
charFound c (x:xs)
    | c == x = True
    | otherwise = charFound c xs

html_head = "<head><style>table {border-collapse: collapse;}table, td, th {border: 1px solid black;}</style></head>"
html_cell s = replace "," "</td><td>" s
html_row s =  replace "\n" "</td></tr>\n<tr><td>" (html_cell s)
html s = "<html>"++html_head++"<body><table><tr><td>" ++ html_row s ++ "</td></tr></table></body></html>"

--csv_to_html "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
csv_to_html csv_file html_file = do
                c <- readFile csv_file
                writeFile html_file (html c)

indent n str
     | n == 0     = str
     | otherwise  = ('\t' : indent (n-1) str)

tags_to_replace = ["<body>","<table>","<tr>","<td>"]
end_tags_to_replace = [ '<': '/' : tail x | x <- tags_to_replace ]

from_tags = tags_to_replace ++ end_tags_to_replace
to_tags   = zipWith (\x y -> if (charFound '/' y ) then ('\n':(indent x y)) else (indent x y) ) ([1.. length tags_to_replace]++[1.. length tags_to_replace]) (from_tags)

pretty_html :: [Char] -> [[Char]] -> [[Char]] -> [Char]
pretty_html s from_tags to_tags
                            | length to_tags == 8 = (replace (head from_tags) (head to_tags) s)
                            | otherwise = (pretty_html s (tail from_tags) (tail to_tags))

--csv_to_pretty_html "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
csv_to_pretty_html csv_file html_file = do
                c <- readFile csv_file
                writeFile html_file (pretty_html (html c) from_tags to_tags)