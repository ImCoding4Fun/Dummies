--ghc 7.10
convMap = [(1000,"M"), (900,"CM"), (500,"D"), (400,"CD"), (100,"C"),(90,"XC"), (50,"L"), (40,"XL"), (10,"X"), (9,"IX"), (5,"V"),(4,"IV"), (1,"I")]

toRoman x = snd $ foldl f (x, []) convMap
  where f (x, s) (a, b) = let (q, r) = quotRem x a in (r, s ++ concat (replicate q b))
              
main = mapM_ putStrLn [show x ++ "\t\t" ++ toRoman x | x <- [1..3999]]