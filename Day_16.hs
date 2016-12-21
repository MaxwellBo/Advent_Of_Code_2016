main :: IO ()
main = do 
  print . checksum $ fillDisk diskLengthOne seed
  print . checksum $ fillDisk diskLengthTwo seed
    where 
      diskLengthOne = 272
      diskLengthTwo = 35651584
      seed = "11100010111110100"

process :: String -> String
process a = a ++ "0" ++ b 
  where
    b = (fmap (\x -> if x == '1' then '0' else '1')) . reverse $ a 

checksum :: String -> String
checksum = (until (odd . length) pairsum) . pairsum

pairsum :: String -> String
pairsum (x:y:xs) 
  | x == y    = '1' : pairsum xs
  | otherwise = '0' : pairsum xs
pairsum _ = []

fillDisk :: Int -> String -> String
fillDisk diskLength = (take diskLength) 
                    . (until (\x -> length x >= diskLength) process)
