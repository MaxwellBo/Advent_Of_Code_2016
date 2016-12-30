-- http://adventofcode.com/2016/day/13

import Numeric
import Data.Char
import Control.Monad.Writer


type Position = (Int, Int)

seed :: Int
seed = 1350

main :: IO ()
main = do 
  print partOne

partOne :: Int
partOne = getSum . execWriter . until (isAtDestination) (>>= moveCount) $ start
  where
    start = return [(1, 1)]
    isAtDestination x = (31, 39) `elem` (fst . runWriter $ x)

moveCount :: [Position] -> Writer (Sum Int) [Position]
moveCount xs = do
  tell (Sum 1)
  return (xs >>= move)

move :: Position -> [Position]
move (x, y) = filter (isOpen) $ [(x, y + 1), (x, y - 1), (x + 1, y), (x - 1, y)]

isOpen :: Position -> Bool
isOpen (x,y)
  | x < 0 || y < 0 = False
  | otherwise = even . length . filter (=='1') . binary $ go
  where
    go = (x*x + 3*x + 2*x*y + y + y*y) + seed
    binary x = showIntAtBase 2 intToDigit x ""
