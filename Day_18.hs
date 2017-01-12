-- https://adventofcode.com/2016/day/18

module Day_18 where

import Data.List.Split
import Data.List

main :: IO ()
main = do
  print ("Part 1", partOne) -- 1956
  print ("Part 2", partTwo) -- 19995121

seed :: String
seed = ".^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^...."
      ++ "...^..^^...^.^.^^..^^^^^...^."

partOne :: Int
partOne = length . filter (== '.') . concat $ makeRoom 40

partTwo = length . filter (== '.') . concat $ makeRoom 400000

makeRoom :: Int -> [String]
makeRoom lines = (take lines) $ (unfoldr deriveNextRow seed)

chunks :: String -> [String]
chunks string = divvy 3 1 ("." ++ string ++ ".")

deriveTrap :: String -> Char
deriveTrap string
  | string == "^^." = '^'
  | string == ".^^" = '^'
  | string == "^.." = '^'
  | string == "..^" = '^'
  | otherwise = '.'

deriveNextRow :: String -> Maybe (String, String)
deriveNextRow this = Just (this, next) 
  where
    next = (fmap deriveTrap) . chunks $ this

