import Data.Function ((&))

import Data.List
import Data.List.Split

main :: IO ()
main = do
  fileContents <- readFile "inputs/Day_7_input.txt"
  print . partOne $ fileContents

partOne :: String -> Int
partOne = length . filter (== True) . (fmap supportsTLS) . lines

tokenize :: String -> ([String], [String])
tokenize string = (fst part, tail <$> snd part)
  where 
    tokens = split (startsWith "[") string 
        >>= split (dropDelims $ endsWith "]") 
    part = (partition (\x -> head x /= '[')) $ tokens

nonEmptySubstrings :: [a] -> [[a]]
nonEmptySubstrings = concatMap (tail . inits) . tails

candidatePalindromes :: String -> [String]
candidatePalindromes = (filter (\x -> (length x) == 4)) . nonEmptySubstrings

isPalindrome :: String -> Bool
isPalindrome string = ((reverse string) == string) 
                    && ((string !! 0) /= string !! 1) 

containsPalindrome :: String -> Bool
containsPalindrome = (True `elem`) . (fmap isPalindrome) . candidatePalindromes

supportsTLS :: String -> Bool
supportsTLS string = outside && not inside
  where 
    tokens = tokenize string
    outside = (any containsPalindrome) $ (fst tokens)
    inside = (any containsPalindrome) $ (snd tokens)
     