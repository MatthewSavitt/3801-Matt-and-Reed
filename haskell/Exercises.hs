module Exercises
    ( change, firstThenApply, powers, meaningfulLineCount,
      Shape(Sphere, Box), volume, surfaceArea,
      BST(Empty, Node), size, contains, insert, inorder
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
powers b = [(b^) n | n <- [0..]]


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



data BST a = Empty | Node a (BST a) (BST a) deriving (Eq)

instance Show a => Show (BST a) where
    show = showBST

showBST :: Show a => BST a -> String
showBST Empty = "()"
showBST (Node x Empty Empty) = "(" ++ show x ++ ")"
showBST (Node x left Empty) = "(" ++ showBST left ++ show x ++ ")"
showBST (Node x Empty right) = "(" ++ show x ++ showBST right ++ ")"
showBST (Node x left right) = "(" ++ showBST left ++ show x ++ showBST right ++ ")"

empty :: BST a
empty = Empty

size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right

contains :: (Ord a) => a -> BST a -> Bool
contains _ Empty = False
contains x (Node y left right)
    | x == y = True
    | x < y = contains x left
    | otherwise = contains x right

insert :: (Ord a) => a -> BST a -> BST a
insert x Empty = Node x Empty Empty
insert x (Node y left right)
    | x < y = Node y (insert x left) right
    | x > y = Node y left (insert x right)
    | otherwise = Node y left right

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node x left right) = inorder left ++ [x] ++ inorder right

