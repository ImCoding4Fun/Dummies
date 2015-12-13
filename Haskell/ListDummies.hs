{-
    Author: A.F.G.
    Content: Haskell first dummies.
    Training purpose only. To be continued.
    When required, credits specified in comments.
    Last update: 12-11-2015.
-}

module ListDummies 
(
    isNullList,
    oddsUpTo,
    filter',
    multiplyList,
    multiplyList',
    multiplyList'',
    tableOf,
    removeOdd,
    removeIf,
    combinations,
    quicksort,
    doubleOdds
)
where

isNullList :: [t] -> Bool
isNullList [] = True
isNullList (x:xs) = False

oddsUpTo :: Int -> [Int]
oddsUpTo n = [ x | x<-[1..n] , odd x ]

filter' :: (t -> Bool) -> [t] -> [t]
filter' f list = [x | x<-list , f x]

{-
	Multiplies each element of a list by the given number 'n'
-}
multiplyList :: Num t => [t] -> t -> [t]
multiplyList [] n = []
multiplyList (x: xs) n = (n *x) : (multiplyList xs n) 

multiplyList' :: Num t => [t] -> t -> [t]
multiplyList'  list n = case list of
    [] -> []
    (x: xs) -> n * x : multiplyList' xs n

multiplyList'' list n
     | length list < 1 = []
     | otherwise = (n * head list) :  multiplyList'' (tail list) n

tableOf :: Int -> [Int]
tableOf n = map (*n) [1..10]

tableOf' :: Int -> [Int]
tableOf' n = map (\x -> x * n) [1..10]

tableOf'' :: Int -> [Int]
tableOf'' n = zipWith (*) [1..10] (repeat n)

tableOf''' :: (Enum t, Num t) => t -> [t]
tableOf''' n = multiplyList'' [1..10] n

removeOdd :: Integral t => [t] -> [t]
removeOdd [] = []
removeOdd (x: xs)
    | mod x 2 == 0 = x : removeOdd xs
    | otherwise    = removeOdd xs

removeIf :: (t-> Bool) -> [t] -> [t]    
removeIf f [] = []
removeIf f (x: xs)
    | f x == True = x : removeIf f xs
    | otherwise = removeIf f xs
 
{-
    n!/k!*(n-k)!
-}   
combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations _ [] = []
combinations n (x:xs) = (map (x:) (combinations (n-1) xs)) ++ (combinations n xs)

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort (filter (<=x) xs)
        biggerSorted = quicksort (filter (>x) xs)
    in  smallerSorted ++ [x] ++ biggerSorted
    
{-
Modad = computation builder
-}
doubleOdds = [1..10] >>= (\x -> if odd x then [x*2] else [])