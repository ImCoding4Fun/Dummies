{-
    Author: A.F.G.
    Content: Haskell first dummies. Training purpose only. To be continued.
    Last update: 08-12-2015.
-}

import Data.Char (toLower,toUpper)
import Data.List (takeWhile, dropWhile,tails)
{-

2^3
8

flip (^) 2 3
9

3^2
9

flip (^) 3 2
8

[ x |x<- [1..100], odd x]

filter (odd) [1..100]
filter (\x -> x `mod` 2 == 0) [1..10]

map (*2) [1..10]

map (\x -> if odd x then x*2 else x*3) [1..10]

length $ filter (\ x -> even x && x > 10) [1..20]

-}

-- Hello world
hello_world :: IO ()
hello_world = putStrLn "Hello, World!"

--Back to the basics! Tables
--table :: Int -> Integer
table n = zipWith (*) [1..10] (repeat n)

--Simple IO program
input_user_info :: IO String
input_user_info = do
    putStrLn "Name"
    name <- getLine
    putStrLn "Surname"
    surname <- getLine
    return ("Name: "++ name ++ "    Surname: " ++ surname) 


-- Factorial of a number
factorial :: Integer -> Integer
factorial n = product [1..n]

-- Funnier factorial
fact :: (Num b, Enum b) => b -> b
fact n = foldl (\acc x -> acc * x) 1 [2..n]

-- Fibonacci sequence
fibonacci :: [Integer]
fibonacci = 0 : 1 : zipWith (+) fibonacci (tail fibonacci)

-- Fibonacci sequence (up to n)
fibonacci_up_to_n :: Int -> [Integer]
fibonacci_up_to_n n = take n (fibonacci)

--To upper of a string
toUpperString :: String -> String
toUpperString string = map toUpper string

-- Count the number of occurrences of a specific character in a string
countOfElem :: Eq a => a -> [a] -> Int
countOfElem elem list = length $ filter (\x -> x == elem) list

{-  
Input: A single string or two words separated by a single space (otherwise it does not work...)
Returns a camel cased string 
I know this sucks; see here https://gist.github.com/ruthenium/3715696 how it should be written 
-}
toCamelCase string = if countOfElem ' ' string == 1 && length(words string) >= 2 then
					 toLower(head string) : tail (map toLower (takeWhile (/=' ') string)) ++ 
					 toUpper((dropWhile (/=' ') string)!!1) : tail(tail (map toLower (dropWhile (/=' ') string)))
					 else
					 "I'm not so smart yet"
-- Prime numbers
primes :: [Integer]
primes = sieve [2..]
  where
    sieve (p:xs) = p : sieve [x|x <- xs, x `mod` p > 0]

-- nth Prime number
nthPrime :: Int -> Integer
nthPrime n = 
         if n <= 1 then error("Invalid input parameter. (Should be greater than zero.)")
         else primes !!(n-1)

-- First n primes
first_nthPrimes :: Int -> [Integer]
first_nthPrimes n =
    if n > 2000 then error("This would take far too long...")
    else take n (primes)
    
--List of all the powers of n where the result is less than m 
powsOf_N_UpTo_M n m = takeWhile (< m ) $ map (^n) [1..]

{-
Quicksort
-}
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
    
{-
map (negate . sum . tail) [[1..5],[3..6],[1..7]]  

[ (replicate 4) x | x<- [1..10] ]
-}

{-
 Combinations
-}
combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs)-1] 
                                  , x <- combinations (n-1) $ drop (i+1) xs ]