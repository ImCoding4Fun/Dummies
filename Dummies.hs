{-
    Author: A.F.G.
    Content: Haskell first dummies. Training purpose only. To be continued.
    Last update: 08-12-2015.
-}

import Data.Char (toLower,toUpper)
import Data.List (takeWhile, dropWhile)

-- Hello world
hello_world :: IO ()
hello_world = putStrLn "Hello, World!"

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
    
