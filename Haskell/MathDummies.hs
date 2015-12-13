{-
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 12-11-2015.
-}

module MathDummies 
(
    factorial,
    factorial',
    factorial'',
    isPrime,
    chain
)
where

factorial :: Integer -> Integer
factorial n = product [1..n]

factorial' :: Integer -> Integer
factorial' n = foldl (\acc x -> acc * x) 1 [2..n]

{-
    Calculate factorial using pattern matching (recursive definition).
-}
factorial'' :: (Integral a) => a -> a
factorial'' 0 = 1
factorial'' n = n * factorial'' (n - 1)

isPrime :: Int -> Bool
isPrime n
    | n <= 1    = False
    | otherwise = not $ any (\x -> n `mod` x == 0) [2,3..(n-1)]
    
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n =  n:chain (n `div` 2)
    | odd n  =  n:chain (n*3 + 1)