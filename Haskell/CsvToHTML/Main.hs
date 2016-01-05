-----------------------------------------------------------------------------
--
-- Module      :  Main
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Main (
    main
) where

import Program

main = do
        let args = ["C:\\vm\\foo.csv","C:\\vm\\foo.html"]
        putStrLn $ "Input : " ++ head args
        x <- csvToPrettyHtml (head args) (args!!1)
        putStrLn $ "Output : " ++ (args!!1)
        putStrLn "HTML File generation completed"
