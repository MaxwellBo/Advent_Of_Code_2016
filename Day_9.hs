-- http://adventofcode.com/2016/day/9

module Day_9 where

import Data.List.Split

main :: IO ()
main = do 
  fileContents <- readFile "inputs/Day_9_input.txt"
  print ("Part 1", part 1 fileContents) -- 115118
  print ("Part 2", part 2 fileContents) -- 11107527530

data Instruction 
  = Literal String 
  | Repeat Int [Instruction]
  deriving (Show)

type Part = Int

parseInstructions :: String -> [Instruction]
parseInstructions [] = []
parseInstructions ('(': xs) = Repeat repeats (parseInstructions take) : parseInstructions rest
  where
    marker =    fst . (break (==')')) $ xs
    (')':xs') = snd . (break (==')')) $ xs
    tok = splitOn "x" marker
    chars = read (tok !! 0)
    repeats = read (tok !! 1)
    (take, rest) = splitAt chars xs'
parseInstructions xss@(x:_) = Literal lit : parseInstructions xs
  where
    (lit, xs) = break (=='(') $ xss

part :: Int -> String -> Int
part n = sum . fmap value . parseInstructions
  where
    value :: Instruction -> Int
    value (Literal xs) = length xs
    value (Repeat repeats ins) = repeats * sum (value <$> ins)