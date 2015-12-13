{-
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 12-11-2015.
-}

module Miscellaneous 
(
    helloWorld,
    threeAsString,
    readAList,
    bmiTell,
    tuples,
    tuples',
    splitAt',
    splitAt''
)
where

helloWorld :: IO ()
helloWorld = putStrLn "Hello, World!"

threeAsString :: String
threeAsString = show 3

readAList = read "[2,2,2]" ++ [1..10]

--Guards example
bmiTell :: (RealFloat a) => a -> String  
bmiTell bmi  
    | bmi <= 18.5 = "You're underweight, you emo, you!"  
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise   = "You're a whale, congratulations!"
    
tuples :: [(Int, Int, Int)]
tuples = do
  a <- [1,2]
  b <- [10,20]
  c <- [100,200]
  return (a,b,c)
-- [(1,10,100),(1,10,200),(1,20,100),(1,20,200),(2,10,100),(2,10,200),(2,20,100),(2,20,200)]

tuples' x y z = do
    a <- x
    b <- y
    c <- z
    return (a,b,c)
    
splitAt' ::  Int -> [a] -> ([a], [a])
splitAt' n xs 
    | n < 0         = ([], xs)
    | n > length xs = (xs, [])
    | otherwise     = splitAt'' n ([], xs)  

splitAt'' :: Int -> ([a], [a]) -> ([a], [a])
splitAt'' 0 (start, end)  = (start, end)
splitAt'' n (xs, (y:ys))  = splitAt'' (n - 1) (xs ++ [y], ys) 