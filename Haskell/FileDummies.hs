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
    toHTMLRow,
    rdUpperFile,
    rdHTMLFile,
    cpFile
)
where
import Data.Char (toUpper)
import Data.String.Utils (replace)

toUpperString str = [ toUpper x | x<-str]

--cabal.exe install MissingH
--FIXME: as is: just a single row...
toHTMLRow str =  "<html><table><tr><td>" ++ replace "," "</td><td>" str ++ "</td><tr></html></table>"

str >>= (\x -> if x==source_ch then dest_ch:"" else x:"")

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
                
--usage cpHTMLFile "C:\\vm\\foo.csv" "C:\\vm\\foo.html"
cpHTMLFile csv_file html_file = do
                contents <- readFile csv_file
                writeFile html_file (toHTMLRow contents)