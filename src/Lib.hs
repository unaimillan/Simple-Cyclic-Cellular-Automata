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

-- | A simple vector inner product
dotp :: Acc (Vector Double) -> Acc (Vector Double) -> Acc (Scalar Double)
dotp xs ys = fold (+) 0 (zipWith (*) xs ys)
