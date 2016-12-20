import Data.Function ((&))

import Data.List.Split
import Data.List
import Data.Ord

import qualified Data.Map as Map

type Room = (String, Integer, String)

main :: IO ()
main = do
  fileContents <- readFile "Day_4_input.txt"
  print . partOne $ fileContents

partOne :: String -> Integer 
go fileContents = lines fileContents
                & fmap readRoom
                & filter isRealRoom
                & fmap (\(_, sectorID, _) -> sectorID)
                & sum

readRoom :: String -> Room
readRoom string = (letters, sectorID, checksum)
  where 
    reversed = reverse string
    tokens = filter (not . null) $ splitOneOf "-[]" reversed
    checksum = reverse $ (tokens !! 0)
    sectorID = read . reverse $ (tokens !! 1)
    letters = concat $ drop 2 tokens

count :: Ord a => [a] -> Map.Map a Integer
count input = Map.fromListWith (+) [(c, 1) | c <- input]

getTopFive :: String -> String
getTopFive = collapse' . sort' . count'
  where 
    collapse' = (fmap fst) . (take 5)
    sort' = (sortBy $ comparing (Down . snd)) . (sortBy $ comparing fst)
    count'= Map.toList . count

isRealRoom :: Room -> Bool
isRealRoom (letters, sectorID, checksum) = go
  where
    go = checksum == getTopFive letters

