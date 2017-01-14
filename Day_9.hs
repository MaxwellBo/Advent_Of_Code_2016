-- http://adventofcode.com/2016/day/9

module Day_9 where

import Data.List.Split
import Control.Parallel.Strategies

main :: IO ()
main = do 
  fileContents <- readFile "inputs/Day_9_input.txt"
  print ("Part 1", part 1 fileContents) -- 115118
  print ("Part 2", part 2 fileContents) -- 11107527530

part :: Int -> String -> Int
part n = sum . fmap (dc n) . lines

-- This is unreadable, I sincerely apologize
dc :: Int -> String -> Int
dc p ('(':xs) = runEval $ do
    l <- rpar $ lf (duplicate repeats $ (take chars xs'))  
    r <- rpar $ dc p (drop chars xs')
    rseq l
    rseq r
    return (l + r)
  where 
    lf = if p == 1 then length else dc p
    marker = fst . (break (==')')) $ xs
    xs' = tail . snd . (break (==')')) $ xs
    tok = splitOn "x" marker
    chars = read (tok !! 0)
    repeats = read (tok !! 1)
    duplicate n = concat . replicate n
dc p (x:xs) = 1 + dc p xs
dc _ [] = 0