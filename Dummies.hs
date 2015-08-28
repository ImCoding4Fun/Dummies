{-
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 08-28-2015.
-}

module Dummies
(
    helloWorld,
    tableOf,
    anotherTableOf,
    yetAnotherTableOf,
    factorial,
    anotherFactorial,
    quicksort,
    chain,
    combinations,
    occurrences,
    split,
    toCamelCase,
    toUpper,
    transformFst
)
where
import Data.Char (toUpper)

helloWorld :: IO ()
helloWorld = putStrLn "Hello, World!"

tableOf :: Int -> [Int]
tableOf n = map (*n) [1..10]

anotherTableOf :: Int -> [Int]
anotherTableOf n = map (\x -> x * n) [1..10]

yetAnotherTableOf :: Int -> [Int]
yetAnotherTableOf n = zipWith (*) [1..10] (repeat n)

factorial :: Integer -> Integer
factorial n = product [1..n]

anotherFactorial :: Integer -> Integer
anotherFactorial n = foldl (\acc x -> acc * x) 1 [2..n]

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort (filter (<=x) xs)
        biggerSorted = quicksort (filter (>x) xs)
    in  smallerSorted ++ [x] ++ biggerSorted

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n =  n:chain (n `div` 2)
    | odd n  =  n:chain (n*3 + 1)

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs)-1]
                                  , x <- combinations (n-1) $ drop (i+1) xs ]

occurrences :: Eq a => a -> [a] -> Int
occurrences element list = length $ filter (\x -> x == element) list

{-|
   Credits: https://gist.github.com/ruthenium
   Transform first letter of 'String' using the function given.
   Will not work on 'Data.Text'.
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

{-|
  Credits: https://gist.github.com/ruthenium
   Convert a 'String' to CamelCase.
   First, split it by \"_\" character.
   Then apply 'capitalize' on each subpart.
   Finally, concat.
-}
toCamelCase :: String -> String
toCamelCase = concat . map' . split (== '_')
  where
    map' = map capitalize

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
