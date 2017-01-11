-- https://adventofcode.com/2016/day/14

{-# LANGUAGE OverloadedStrings #-}

import Data.Digest.Pure.MD5 (md5)
import qualified Data.ByteString.Lazy.Char8 as C
import Data.Monoid
import Data.Maybe
import Control.Monad
import Data.List 

type Hash = String
type Index = Int
type Pair = (Index, Hash)

hashes :: [Pair]
hashes = fmap (\x -> (x, show . md5 $ ("abc" <> (C.pack . show $ x)))) [0..]

main :: IO ()
main = do 
  print hashes

subsequencesOfLength :: Int -> String -> [String]
subsequencesOfLength n = filter ((n==) . length) . subsequences

-- quintupleFollows :: Char -> Maybe ()
-- quintupleFollows = undefined

-- containsTriple :: Hash -> Maybe Char
-- containsTriple = listToMaybe <=< listToMaybe . subsequencesOfLength 3

-- isKey :: [Pair] -> Maybe ()
-- isKey p@(index, hash) = quintupleFollows p <=< containsTriple hash