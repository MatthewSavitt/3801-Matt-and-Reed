module Exercises
    ( change, firstThenApply, powers, meaningfulLineCount,
      Shape(Sphere, Box), volume, surfaceArea
    ) where


import qualified Data.Map as Map
import Data.Text (pack, unpack, replace)
import Data.List(isPrefixOf, find)
import Data.Char(isSpace)

change :: Integer -> Either String (Map.Map Integer Integer)
change amount
    | amount < 0 = Left "amount cannot be negative"
    | otherwise = Right $ changeHelper [25, 10, 5, 1] amount Map.empty
        where
          changeHelper [] remaining counts = counts
          changeHelper (d:ds) remaining counts =
            changeHelper ds newRemaining newCounts
              where
                (count, newRemaining) = remaining `divMod` d
                newCounts = Map.insert d count counts


firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs p f = f <$> find p xs


powers :: (Integral a) => a -> [a]
powers b = [b^n | n <- [0..]]


meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount path = do
    contents <- readFile path
    return $ length $ filter meaningfulLine $ lines contents
    where
      meaningfulLine line = not (null line) && not (all isSpace line) && not ("#" `isPrefixOf` (dropWhile isSpace line))


data Shape = Sphere Double | Box Double Double Double deriving (Show, Eq)

volume :: Shape -> Double
volume (Sphere r) = 4/3 * pi * r^3
volume (Box l w h) = l * w * h

surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * r^2
surfaceArea (Box l w h) = 2 * (l*w + l*h + w*h)

is_approx :: Double -> Double -> Bool
is_approx x y = abs (x - y) < 1e-9  -- tolerance level for approximation


-- Write your binary search tree algebraic type here
