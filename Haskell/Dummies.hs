{-
    --DEPRECATED--
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 10-14-2015.
-}

module Dummies
(
    helloWorld,
    oddsUptoN,
    threeAsString,
    readAList,
    tableOf,
    anotherTableOf,
    yetAnotherTableOf,
    factorial,
    anotherFactorial,
    yetAnotherFactorial,
    quicksort,
    chain,
    combinations,
    occurrences,
    split,
    toCamelCase,
    toUpper,
    invertCase,
    transformFst,
    bmiTell,
    isPrime,
    isPalindrome,
    splitAt',
    multiplyList,
    ultimateTableOf,
    removeOdd,
    isNull
)
where
import Data.Char (toUpper,toLower,isUpper,toTitle)

isNull :: [t] -> Bool
isNull [] = True
isNull (x:xs) = False 

helloWorld :: IO ()
helloWorld = putStrLn "Hello, World!"

oddsUptoN :: Int -> [Int]
oddsUptoN n = [ x | x<-[1..n] , odd x ]

threeAsString = show 3

readAList = read "[2,2,2]" ++ [1..10]

tableOf :: Int -> [Int]
tableOf n = map (*n) [1..10]

anotherTableOf :: Int -> [Int]
anotherTableOf n = map (\x -> x * n) [1..10]

yetAnotherTableOf :: Int -> [Int]
yetAnotherTableOf n = zipWith (*) [1..10] (repeat n)

ultimateTableOf :: (Enum t, Num t) => t -> [t]
ultimateTableOf n = multList [1..10] n

{-
	Multiplies each element of a list by the given number 'n'
-}
multiplyList :: Num t => [t] -> t -> [t]
multiplyList [] n = []
multiplyList (x: xs) n = (n *x) : (multiplyList xs n) 

multList :: Num t => [t] -> t -> [t]
multList list n = case list of
    [] -> []
    (x: xs) -> n * x : multList xs n

guardsMultiplyList list n
     | length list < 1 = []
     | otherwise = (n * head list) :  guardsMultiplyList (tail list) n 

removeOdd [] = []
removeOdd (x: xs)
    | mod x 2 == 0 = x : removeOdd xs
    | otherwise    = removeOdd xs
  
factorial :: Integer -> Integer
factorial n = product [1..n]

anotherFactorial :: Integer -> Integer
anotherFactorial n = foldl (\acc x -> acc * x) 1 [2..n]

{-
    Calculate factorial using pattern matching (recursive definition).
-}
yetAnotherFactorial :: (Integral a) => a -> a
yetAnotherFactorial 0 = 1
yetAnotherFactorial n = n * yetAnotherFactorial (n - 1)  

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
occurrences :: Eq a => a -> [a] -> Int
occurrences element list = length $ filter (\x -> x == element) list

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

{-
Modad = computation builder
-}
doubleOdds = [1..10] >>= (\x -> if odd x then [x*2] else [])

invertCase s = s >>= (\x -> if isUpper x then toLower x:"" else toUpper x:"")


example :: [(Int, Int, Int)]
example = do
  a <- [1,2]
  b <- [10,20]
  c <- [100,200]
  return (a,b,c)
-- [(1,10,100),(1,10,200),(1,20,100),(1,20,200),(2,10,100),(2,10,200),(2,20,100),(2,20,200)]

--Guards example
bmiTell :: (RealFloat a) => a -> String  
bmiTell bmi  
    | bmi <= 18.5 = "You're underweight, you emo, you!"  
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise   = "You're a whale, congratulations!"  

isPrime :: Int -> Bool
isPrime n
    | n <= 1    = False
    | otherwise = not $ any (\x -> n `mod` x == 0) [2,3..(n-1)]

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = x == reverse x

splitAt' :: [a] -> Int -> ([a], [a])
splitAt' xs n
    | n < 0         = ([], xs)
    | n > length xs = (xs, [])
    | otherwise     = splitAt'' ([], xs) n 

splitAt'' :: ([a], [a]) -> Int -> ([a], [a])
splitAt'' (start, end) 0 = (start, end)
splitAt'' (xs, (y:ys)) n = splitAt'' (xs ++ [y], ys) (n - 1)