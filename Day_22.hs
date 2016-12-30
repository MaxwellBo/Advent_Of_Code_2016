-- https://adventofcode.com/2016/day/22

import Control.Monad
import Data.List.Split

data Node = Node
  { name :: String
  , x :: Int
  , y :: Int
  , size :: Int
  , used :: Int
  , available :: Int
  , percentage :: Int 
  }

instance Show Node where
  show node
    | used node == 0 = "_" 
    | x node == 32 && y node == 0 = "G"
    | x node == 0 && y node == 0 = "O"
    | size node > 150 = "#"
    | otherwise = "."

main :: IO ()
main = do
  fileContents <- readFile "inputs/Day_22_input.txt"
  print . partOne $ fileContents -- 967
  putStrLn . partTwo $ fileContents

partOne :: String -> Int
partOne = length . viablePairs . parseNodes

partTwo :: String -> String
partTwo = showNodes . parseNodes

parseNodes :: String -> [Node]
parseNodes = (fmap parseNode) . drop 2 . lines

showNodes :: [Node] -> String 
showNodes = unlines . (chunksOf 30) . reverse . concat . (fmap show)

viablePairs :: [Node] -> [(Node, Node)]
viablePairs xs = do
  a <- xs
  b <- xs
  guard (used a /= 0 )
  guard (name a /= name b)
  guard (used a <= available b)
  return (a, b)

parseNode :: String -> Node
parseNode xs = Node name x y size used available percentage
  where
    name = (flip (!!) 0) . words $ xs
    x = read . tail . (flip (!!) 1) . wordsBy (=='-') $ name
    y = read . tail . (flip (!!) 2) . wordsBy (=='-') $ name
    info = fmap (read . init ) . words $ xs
    size = info !! 1
    used = info !! 2
    available = info !! 3
    percentage = info !! 4