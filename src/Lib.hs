{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RebindableSyntax #-}

-- |
-- Module      : Lib
-- Copyright   : [2021] Author name here
-- License     : BSD3
--
-- Maintainer  : Author name here <example@example.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
module Lib where

-- ( dotp,
-- )

import Data.Array.Accelerate
import qualified Prelude as P

-- | A simple vector inner product
dotp :: Acc (Vector Double) -> Acc (Vector Double) -> Acc (Scalar Double)
dotp xs ys = fold (+) 0 (zipWith (*) xs ys)

type Cell = Word8

type World = Matrix Cell

worldSize = 256