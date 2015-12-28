module RGB 
where

data RGB = RGB Int Int Int
     deriving Eq

--Longer way of deriving Eq:
--instance Eq RGB where
--                      (RGB r1 g1 b1) == (RGB r2 g2 b2) =
--                          (r1 == r2) && (g1 == g2) && (b1 == b2)

--toString
instance Show RGB where
                       show (RGB r g b) =
                           "RGB: " ++ (show r) ++ " " ++ (show g) ++ " " ++ (show b) 

colors = [ RGB 255 0 0, RGB 0 255 0, RGB 0 0 255 ]
green = RGB 0 255 0

elem' _ [] = False
elem' x (y: ys)
     | x == y    = True
     | otherwise =  elem x ys