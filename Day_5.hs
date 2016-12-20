import Data.Function ((&))

main :: IO ()
main = do
  fileContents <- readFile "Day_4_input.txt"
  print . DayOne $ fileContents