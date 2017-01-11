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
hashes = fmap (x, \x -> (show . md5 $ ("abc" <> (C.pack . show $ x)))) [0..]

main :: IO ()
main = do 
  print hashes

xtuples :: Int -> String -> [String]
xtuples n = filter isHomogeneous . filter ((n==) . length) . subsequences

isHomogeneous :: String -> Bool
isHomogeneous xs = and $ zipWith (==) xs (tail xs)

quintupleFollows :: Int -> Char -> Bool
quintupleFollows index char = (char `elem`)
                            . nub
                            . mconcat
                            . fmap (quintupleChars)
                            . take 1000
                            . drop index 
                            $ hashes

quintupleChars :: Hash -> [Char]
quintupleChars = nub 
               . fmap head 
               . xtuples 5
                            
tripleChar :: Hash -> Char
tripleChar = fromMaybe '?'
           . listToMaybe
           . fmap head
           . xtuples 3

isKey :: [Pair] -> Maybe ()
isKey (index, hash) = quintupleFollows index . tripleChar $ hash