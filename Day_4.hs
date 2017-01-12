-- http://adventofcode.com/2016/day/4

{-# LANGUAGE RecordWildCards #-}

module Day_4 where

import Data.List.Split
import Data.List
import Data.Ord
import Data.Char

import qualified Data.Map as Map

data Room = Room
  { name :: String
  , letters :: String
  , sectorID :: Integer
  , checksum :: String
  }

main :: IO ()
main = do
  fileContents <- readFile "inputs/Day_4_input.txt"
  print . partOne $ fileContents -- 173787
  print . partTwo $ fileContents -- 548

partOne :: String -> Integer 
partOne = sum
        . fmap sectorID
        . getRealRooms

partTwo :: String -> Integer
partTwo = head
        . fmap snd
        . filter (\(x, _) -> "northpolecobject" `isPrefixOf` x)
        . fmap (\x -> (name x, sectorID x))
        . fmap shift
        . getRealRooms

getRealRooms :: String -> [Room]
getRealRooms = filter isRealRoom
             . fmap readRoom
             . lines

readRoom :: String -> Room
readRoom string = Room {..}
  where 
    name = string
    reversed = reverse string
    tokens = filter (not . null) $ splitOneOf "-[]" reversed
    checksum = reverse $ (tokens !! 0)
    sectorID = read . reverse $ (tokens !! 1)
    letters = concat $ drop 2 tokens

shift :: Room -> Room
shift Room {..} = Room { name = (map (shiftChar sectorID)) $ name, .. }

shiftChar :: Integer -> Char -> Char
shiftChar offset =  castOut . rotate . castIn
  where castIn = flip (-) (ord 'a') . ord
        rotate = (`mod` 26) . (+(fromInteger offset))
        castOut = chr . (+ ord 'a')

count :: Ord a => [a] -> Map.Map a Integer
count input = Map.fromListWith (+) [(c, 1) | c <- input]

getTopFive :: String -> String
getTopFive = collapse' . sort' . count'
  where 
    collapse' = (fmap fst) . (take 5)
    sort' = (sortBy $ comparing (Down . snd)) . (sortBy $ comparing fst)
    count'= Map.toList . count

isRealRoom :: Room -> Bool
isRealRoom Room {..} = checksum == getTopFive letters

