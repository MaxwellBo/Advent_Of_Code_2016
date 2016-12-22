-- https://adventofcode.com/2016/day/18

import Data.List.Split
import Data.List

main :: IO ()
main = do 
  print partOne -- 1956
  print partTwo

seed :: String
seed = ".^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^...."
      ++ "...^..^^...^.^.^^..^^^^^...^."

lines' :: Int
lines' = 40

partOne :: Int
partOne = length . filter (== '.') . concat $ makeRoom 40

partTwo :: Int
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

