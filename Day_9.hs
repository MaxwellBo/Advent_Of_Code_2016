-- http://adventofcode.com/2016/day/9

module Nine where

import Data.List.Split
import Control.Parallel.Strategies

main :: IO ()
main = do 
  fileContents <- readFile "inputs/Day_9_input.txt"
  print . partBoth $ fileContents 
  -- Part One: 115118
  -- Part Two: 11107527530
  -- ^ took about 10 minutes, compiled with -O3 -threaded -rtsopts
  -- and executed with +RTS -N4 

partBoth :: String -> Int
partBoth = sum . fmap dc . lines 

-- For Part Two, change "length" to "dc" in the 'l' evaluation
dc :: String -> Int
dc ('(':xs) = runEval $ do
    l <- rpar $ length (duplicate repeats $ (take chars xs'))  
    r <- rpar $ dc (drop chars xs')
    rseq l
    rseq r
    return (l + r)
  where 
    marker = fst . (break (==')')) $ xs
    xs' = tail . snd . (break (==')')) $ xs
    tok = splitOn "x" marker
    chars = read (tok !! 0)
    repeats = read (tok !! 1)
    duplicate n = concat . replicate n
dc (x:xs) = 1 + dc xs
dc [] = 0