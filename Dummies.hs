import Data.Char (toLower,toUpper)
import Data.List (takeWhile, dropWhile)

factorial n = product [1..n]

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
fibs_up_to_n n = take n (fibs)

toUpperString string = map toUpper string

{-
	Count the number of occurrences of a specific character in a string
-}
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
{-
Prime numbers
-}
primes :: [Integer]
primes = sieve [2..]
  where
    sieve (p:xs) = p : sieve [x|x <- xs, x `mod` p > 0]

{-
nth Prime number
-}
nthPrime n = primes !!(n-1)