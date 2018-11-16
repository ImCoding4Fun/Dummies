isPrime n
    | n <= 1    = False
    | otherwise = not $ any (\x -> n `mod` x == 0) [2,3..(n-1)]

digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

rotate p n = r * 10 + q
      where (q,r) = n `quotRem` p

rotations 0 = [0]
rotations n = n : takeWhile (/=n) (tail $ iterate (rotate (10^d)) n)
    where d = floor (log (fromInteger n) / log 10)

isCircularPrime n
    | not $ isPrime n = False
    | otherwise = all (\x -> isPrime x) $ rotations n

-- Solution to problem 35
how_many_circular_primes_are_there_below_one_million =
    length $ filter isCircularPrime [1..1000000]

count x = length . filter (x==)

quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort (filter (<=x) xs)
        biggerSorted = quicksort (filter (>x) xs)
    in  smallerSorted ++ [x] ++ biggerSorted

isPandigital n =
    (quicksort $ digs n) == [1..length $ digs n]
--map (snd) $ filter ((==True).fst) [ (x == y,y) | x<- digs n, y<-[1..length $ digs n] ]
--[ (x == y,y) | x<- digs n, y<-[1..length $ digs n] ]

isPandigitalPrime n
    | not $ isPrime n = False
    | otherwise = isPandigital n

--Solution to problem 45 (takes very long...)
aAa = take 1 $ filter (isPandigitalPrime) [987654321,987654319..1]