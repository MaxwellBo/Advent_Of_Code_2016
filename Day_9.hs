-- http://adventofcode.com/2016/day/9

import Data.List.Split

data Atom = Marker Int Int
          | Expr String
          deriving (Show)

main :: IO ()
main = do 
  fileContents <- readFile "input/Day_9_input.txt"
  print . partOne $ fileContents
  print "Hello world"

partOne :: String -> Int
partOne _ = 5

go :: String -> String
go ('(':xs) = (duplicate reps $ (take chars rest)) ++ go (drop chars rest)
  where 
    marker = fst . (break (==')')) $ xs
    rest = tail . snd . (break (==')')) $ xs
    tok = splitOn "x" marker
    chars = read (tok !! 0)
    reps = read (tok !! 1)
    duplicate n = concat . replicate n
go (x:xs) = x : go xs
go [] = ""