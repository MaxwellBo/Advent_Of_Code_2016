import Data.List.Split
import Data.List
import Data.Ord

import qualified Data.Map as Map

type Room = (String, Integer, String)

main :: IO ()
main = putStrLn =<< readFile "Day_4_input.txt"

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

-- tiebreakAlphabetically :: (Char, Integer) -> (Char, Integer) -> Ordering
-- tiebreakAlphabetically (c0, i0) (c1, i1)
--   | i0 /= i1 = compare i0 i1
--   | otherwise = compare c0 c1

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

