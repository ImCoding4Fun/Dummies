import Data.Char (toUpper,toLower,isUpper,toTitle)

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = x == reverse x

compress :: (Eq a) => [a] -> [a]
compress []  = []
compress [x] = [x] -- also can do (x:[]) to be clear what the pattern is.
compress (x:y:xs)
    | x == y    = x : (compress xs)
    | otherwise = x : y : (compress xs)


duplicate :: [a] -> [a]
duplicate []     = []
duplicate (x:xs) = [x, x] ++ duplicate xs

tableOf :: Int -> [Int]
tableOf x = [ x *n |  n <- [1..10] ]

yetAnotherTableOf :: Int -> [Int]
yetAnotherTableOf n = zipWith (*) [1..10] (repeat n)

invertCase :: [Char] -> [Char]
invertCase s = s >>= (\x -> if isUpper x then toLower x:"" else toUpper x:"")

toKebabCase :: [Char] -> [Char]
toKebabCase s  = toLower (s!!0) : (tail s >>= ( \x -> if isUpper x then ['-'] ++ [toLower x] else [x] )) 


trim :: [Char] -> [Char]
trim [] = []
trim (x:xs) | elem x [' ', '\t', '\n'] = trim xs
            | otherwise = x : trim xs

trim2 :: [Char] -> [Char]
trim2 = ltrim . rtrim

ltrim :: [Char] -> [Char]
ltrim = dropWhile (`elem` " \t")

rtrim :: [Char] -> [Char]
rtrim = reverse . ltrim . reverse

containsEdge :: [Int] -> (Int,Int) -> Bool
xs `containsEdge` (a,b) = (a `elem` xs) && (b `elem` xs)

len :: [a] -> Integer
len = sum . map (\_ -> 1)

without :: Eq b => [b] -> b -> [b]
s `without` i = s >>= (\x -> if x/=i then [x] else [])

withoutCapitalized :: [Char] -> Char -> [Char]
s `withoutCapitalized` c = (s >>= (\x -> if x/=c then [x] else [])) >>= (\x -> [toUpper x])


withoutKebabized :: [Char] -> Char -> [Char]
s `withoutKebabized` c = (s >>= (\x -> if toLower x/= toLower c then [x] else [])) >>=  tail . (\x -> if isUpper x then ['-'] ++ [toLower x] else [x] )
