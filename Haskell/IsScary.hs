import System.IO
import Data.Char

is' :: [Char] -> Bool
is' word
    | isAlphaOnly word && foldl (\acc c -> acc + ord (toUpper c) - ord 'A' + 1) 0 word == 13 = True
    | otherwise = False
    where isAlphaOnly = all (isAlpha)

intVal :: Char -> Int
intVal c = ord ( toLower c ) - 96

is'' :: [Char] -> Bool
is'' word = sum [ intVal c | c <- word, isAscii c, isLetter c ] == 13

is''' word = 
    let
      filtered :: String
      filtered = map toLower $ filter isAlpha word
      charToInt :: Char -> Int
      charToInt c = ord c - ord 'a' + 1
    in
      sum (map charToInt filtered) == 13