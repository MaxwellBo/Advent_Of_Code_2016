-- http://adventofcode.com/2016/day/19

import Data.Sequence as S

type Elfs = S.Seq Int

main :: IO ()
main = do
  print partOne -- 1830117
  print partTwo -- 1417887

partOne :: Elfs
partOne = until ((1==) . S.length) (rotate . popNext) elfs

partTwo :: Elfs
partTwo = until ((1==) . S.length) (rotate . popOpposite) elfs

elfs :: Elfs
elfs = S.fromList [1..3012210]

popOpposite :: Elfs -> Elfs
popOpposite elfs = S.deleteAt index elfs
  where
    index = S.length elfs `div` 2

popNext :: Elfs -> Elfs
popNext = S.deleteAt 1

rotate :: Elfs -> Elfs
rotate elfs = S.drop 1 elfs >< S.take 1 elfs