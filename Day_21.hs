import Data.List
import Data.Either
import Control.Applicative


main :: IO ()
main = putStrLn "Hello World"

swapElemsAt :: Int -> Int -> [a] -> [a]
swapElemsAt a b xs = left ++ [xs !! b] ++ middle ++ [xs !! a] ++ right
  where
    left = take a xs
    middle = drop (succ a) (take b xs)
    right = drop (succ b) xs

swapElems :: (Eq a) => a -> a -> [a] -> [a]
swapElems a b xs = swapElemsAt a' b' xs
  where 
    (Just a') = elemIndex a xs
    (Just b') = elemIndex b xs 

rotate :: Either () () -> Int -> [a] -> [a]
rotate (Left _) n xs = drop n xs ++ take n xs
rotate (Right _) n xs = rotate (Left ()) (length xs - n) xs

rotateOnPos :: (Eq a) => a -> [a] -> [a]
rotateOnPos x xs 
  = if pos >= 4 then
      rotate (Right ()) (pos + 2) xs
    else
      rotate (Right ()) (pos + 1) xs 
  where
    (Just pos) = elemIndex x xs

reverseSpan :: Int -> Int -> [a] -> [a]
reverseSpan a b xs = left ++ reverse middle ++ right
  where
    left = take a xs
    middle = drop a (take (succ b) xs)
    right = drop (succ b) xs