import Data.List
import Data.Either
import Control.Applicative
import qualified Data.Sequence as S
import Data.Foldable

main :: IO ()
main = putStrLn "Hello World"

--swapElemsAt a b xs = left ++ [xs !! b] ++ middle ++ [xs !! a]
--  where
--    left = take a xs
--    middle = drop (succ a) (take b xs)
--    right = drop (succ b) xs

swapElemsAt :: Int -> Int -> [a] -> [a]
swapElemsAt a b = reverseSpan (a + 1) (b - 1) . reverseSpan a b

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

-- Sue me
move :: Int -> Int -> [a] -> [a]
move a b xs = toList . (S.insertAt b elem) . (S.deleteAt a) . S.fromList $ xs
  where 
    elem = S.index (S.fromList xs) a