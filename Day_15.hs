-- http://adventofcode.com/2016/day/1

module Day_15 where

import Data.List.Split

type Position = Int
type Positions = Int
type Disc = (Position, Positions)

main :: IO ()
main = do
  fileContents <- readFile "sample.txt"
  print ("Part 1", partOne fileContents)

partOne = (fmap parseDisc) . lines

parseDisc :: String -> Disc
parseDisc xs = (read $ tok !! 3, read $ tok !! 11)
  where
    tok = splitOn " " . init $ xs
