-- http://adventofcode.com/2016/day/9

import Data.List.Split

main :: IO ()
main = do 
  fileContents <- readFile "inputs/Day_9_input.txt"
  print . partOne $ fileContents -- 115118

partOne :: String -> Int
partOne = sum . fmap dc . lines 

-- For Part Two, change "length" to "dc"
dc :: String -> Int
dc ('(':xs) = length (duplicate repeats $ (take chars xs')) + dc (drop chars xs')
  where 
    marker = fst . (break (==')')) $ xs
    xs' = tail . snd . (break (==')')) $ xs
    tok = splitOn "x" marker
    chars = read (tok !! 0)
    repeats = read (tok !! 1)
    duplicate n = concat . replicate n
dc (x:xs) = 1 + dc xs
dc [] = 0