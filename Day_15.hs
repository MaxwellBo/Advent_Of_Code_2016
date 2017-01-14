-- http://adventofcode.com/2016/day/1

module Day_15 where

import Data.List.Split
import Data.Bifunctor

type Position = Int
type Positions = Int
type Disc = (Position, Positions)

main :: IO ()
main = do
  fileContents <- readFile "inputs/Day_15_input.txt"
  print ("Part 1", partOne fileContents) -- 148737

partOne :: String -> Int
partOne = length . takeWhile (not.allClear) . iterate wait . parseDiscs
  where 
    parseDiscs = compensate . (fmap parseDisc) . lines 

compensate :: [Disc] -> [Disc]
compensate = zipWith (\y (a, b)-> (a + y, b)) [1..]

wait :: [Disc] -> [Disc]
wait = fmap.first $ (+1)

allClear :: [Disc] -> Bool
allClear = all isOpen
  where
    isOpen disc = (fst disc `mod` snd disc) == 0

parseDisc :: String -> Disc
parseDisc xs = (read $ tok !! 11, read $ tok !! 3)
  where
    tok = splitOn " " . init $ xs
