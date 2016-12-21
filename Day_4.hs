-- http://adventofcode.com/2016/day/4

import Data.Function ((&))

import Data.List.Split
import Data.List
import Data.Ord
import Data.Char

import qualified Data.Map as Map

type Room = (String, Integer, String)

main :: IO ()
main = do
  fileContents <- readFile "inputs/Day_4_input.txt"
  print . partOne $ fileContents
  putStrLn . partTwo $ fileContents

partOne :: String -> Integer 
partOne fileContents = getRealRooms fileContents 
                     & fmap (\(_, sectorID, _) -> sectorID)
                     & sum

partTwo :: String -> String
partTwo fileContents = getRealRooms fileContents
                     & fmap shift
                     & fmap (\(letters, _, _) -> letters)
                     & unlines

getRealRooms :: String -> [Room]
getRealRooms fileContents = lines fileContents
                          & fmap readRoom
                          & filter isRealRoom

readRoom :: String -> Room
readRoom string = (letters, sectorID, checksum)
  where 
    reversed = reverse string
    tokens = filter (not . null) $ splitOneOf "-[]" reversed
    checksum = reverse $ (tokens !! 0)
    sectorID = read . reverse $ (tokens !! 1)
    letters = concat $ drop 2 tokens

shift :: Room -> Room
shift (letters, sectorID, checksum) = go
  where 
    go = ((map (shiftChar sectorID)) $ letters, sectorID, checksum)

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
isRealRoom (letters, sectorID, checksum) = checksum == getTopFive letters

