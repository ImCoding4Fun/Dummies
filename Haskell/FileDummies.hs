{-
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 12-11-2015.
-}

module FileDummies
(
    toUpperString,
    rdFile,
    toHTML,
    toHTMLRow,
    toHTMLCell,
    rdUpperFile,
    rdHTMLFile,
    cpFile
)
where
import Data.Char (toUpper)
import Data.String.Utils (replace)

toUpperString str = [ toUpper x | x<-str]

--cabal.exe install MissingH
indent n str
     | n == 0     = str
     | otherwise  = "\t" ++ indent (n-1) str

--let html_indents = zip [0..] ["<html>","<body>","<table>","<tr>","<td>"]
--try zipWith             
--toPrettyHTML html_str = map (\x y -> ()) ([ fst(x), snd(x) | x<- zip [0..] ["<html>","<body>","<table>","<tr>","<td>"] ])


--Thanks to laziness, there's no difference between reading the file all at once and reading it line by line.
rdFile file = do
              contents <- readFile file
              mapM_ putStrLn (lines contents)
              
rdUpperFile file = do
              contents <- readFile file
              mapM_ putStrLn (lines $ toUpperString contents)

--usage rdHTMLFile "C:\\vm\\foo.csv"
rdHTMLFile csv_file = do
                contents <- readFile csv_file
                mapM_ putStrLn (lines $ toHTMLRow contents)
              
--usage: cpFile "C:\\vm\\foo.txt" "C:\\vm\\foo-out.txt"
cpFile file_in file_out = do
                contents <- readFile file_in
                writeFile  file_out contents

head' = "<head><style>table {border-collapse: collapse;}table, td, th {border: 1px solid black;}</style></head>"
toHTML str = "<html>"++head'++"<body><table border='1'><tr><td>" ++ toHTMLRow str ++ "</td></tr></table></body></html>"
toHTMLRow str =  replace "\n" "</td></tr>\n<tr><td>" (toHTMLCell str)
toHTMLCell str = replace "," "</td><td>" str

--usage cpHTMLFile "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
--cpHTMLFile "C:\\vm\\DettaglioCartaCircolazioneVeicolo.txt" "C:\\vm\\DettaglioCartaCircolazioneVeicolo.html"
--cpHTMLFile "C:\\vm\\DettaglioAutoveicoloComproprietari.txt" "C:\\vm\\DettaglioAutoveicoloComproprietari.html"
cpHTMLFile csv_file html_file = do
                contents <- readFile csv_file
                writeFile html_file (toHTML contents)

--indent_html str = map (\x y -> replace x y str) [y, indent x y | x<-[0..] , y<-["<html>","<body>","<table>","<tr>","<td>"]]