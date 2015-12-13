{-
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 12-11-2015.
-}

module StringDummies
(
    replace,
    invertCase,
    isPalindrome,
    occurrencies,
    transformFst,
    capitalize,
    applyFunction,
    split,
    toCamelCase,
    solveRPN
)
where
import Data.Char (toUpper,toLower,isUpper,toTitle)
import Data.List
replace source_ch dest_ch str =
    str >>= (\x -> if x==source_ch then dest_ch:"" else x:"")
    
invertCase s = s >>= (\x -> if isUpper x then toLower x:"" else toUpper x:"")

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = x == reverse x

{-
  $ = avoids curved brackets.
  E.g. sum $ filter (odd) [1..10] is equal to sum(filter (odd) [1..10])

  Signature reading:

  :: = has type of...
  the => symbol is called a class constraint

  In addition:
  :: = type annotation, e.g. read "5" :: Int

  The function works with "Equitable" objects A (such as int, chars, dates...)
  It takes an A and a list of As and returns an Integer (the number of occurrencies)

-}
occurrencies :: Eq a => a -> [a] -> Int
occurrencies element list = length $ filter (\x -> x == element) list

{-|
   Credits: https://gist.github.com/ruthenium
   Transform first letter of 'String' using the function given.
   Will not work on 'Data.Text'.

   transformFst input:
        A function that takes a char and returns a char
        A string
   transformFst output:
        A string

   Simple usage:


-}
transformFst :: (Char -> Char) -> String -> String
transformFst _ [] = []
transformFst f (x:xs) = (f x):xs

{-|
   Credits: https://gist.github.com/ruthenium
   Make 'String' begin with a capital letter using 'toUpper' transformation.
-}
capitalize :: String -> String
capitalize = transformFst toUpper

applyFunction f = transformFst f


{-|
   Credits: https://gist.github.com/ruthenium
   Split a 'String' into list of Strings.
   It is just a Prelude function 'words', but it accpets a specified
   predicate to determine delimiter.
   NOTE: It won't work on 'Data.Text'.
   Usage: split (==';') "xx;yy;zz" or split (\x-> x ==';') "xx;yy;zz"
-}
split :: (Char -> Bool) -> String -> [String]
split predicate seqce = case dropWhile predicate seqce of
    "" -> []
    seqce' -> w : split predicate seqce''
          where
            (w, seqce'') = break predicate seqce'

{-|
  Credits: https://gist.github.com/ruthenium
   Convert a 'String' to CamelCase.
   First, split it by \"_\" character.
   Then apply 'capitalize' on each subpart.
   Finally, concat.

   var' = a new variable, related to the original var in the way expresses in the right hand of the expression
-}
toCamelCase :: String -> String
toCamelCase = concat . map' . split (== '_')
  where
    map' = map capitalize
    
{-
  . = function combining
  : => 1:[2..10] = [1..10]
-}
solveRPN :: String -> Float
solveRPN = head . foldl foldingFunction [] . words
    where   foldingFunction (x:y:ys) "*" = (x * y):ys
            foldingFunction (x:y:ys) "+" = (x + y):ys
            foldingFunction (x:y:ys) "-" = (y - x):ys
            foldingFunction (x:y:ys) "/" = (y / x):ys
            foldingFunction (x:y:ys) "^" = (y ** x):ys
            foldingFunction (x:xs) "ln" = log x:xs
            foldingFunction xs "sum" = [sum xs]
            foldingFunction xs numberString = read numberString:xs