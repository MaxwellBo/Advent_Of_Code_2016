-- http://adventofcode.com/2016/day/13

import Data.Bits
import Data.List

type Position = (Int, Int)

seed :: Int
seed = 1350

main :: IO ()
main = do 
  print partOne

partOne :: Int
partOne = length . takeWhile (\x -> not $ ((31, 39) `elem` x)) $ search 
  where
    search = iterate (nub . concatMap move) [(1, 1)]

move :: Position -> [Position]
move (x, y) = filter (isOpen) $ [(x, y + 1), (x, y - 1), (x + 1, y), (x - 1, y)]

isOpen :: Position -> Bool
isOpen (x,y)
  | x < 0 || y < 0 = False
  | otherwise = even . popCount $ (x*x + 3*x + 2*x*y + y + y*y) + seed