import Data.Function ((&))

import Data.List
import Data.List.Split

main :: IO ()
main = do
  fileContents <- readFile "Day_7_input.txt"
  print . partOne $ fileContents

nonEmptySubstrings :: [a] -> [[a]]
nonEmptySubstrings = concatMap (tail . inits) . tails

partOne :: String -> Int
partOne = length . filter (== True) . (fmap supportsTLS) . lines

tokenize :: String -> [String]
tokenize = splitOneOf "-[]"

candidatePalindromes :: String -> [String]
candidatePalindromes = (filter (\x -> (length x) == 4)) . nonEmptySubstrings

isPalindrome :: String -> Bool
isPalindrome string = ((reverse string) == string) 
                    && ((string !! 0) /= string !! 1) 

containsPalindrome :: String -> Bool
containsPalindrome = any . (fmap isPalindrome) . candidatePalindromes

supportsTLS :: String -> Bool
supportsTLS string = outside && not inside
  where 
    tokens = tokenize string
    outside = containsPalindrome (tokens !! 0) || containsPalindrome (tokens !! 2)
    inside = containsPalindrome (tokens !! 1)