{-# LANGUAGE TypeOperators #-}

module CCA.Automata where

import CCA.Types
import Data.Array.Accelerate
import Data.Array.Accelerate.System.Random.MWC as A
import qualified Prelude as P

-- | Creates one sell of the 2 dimensional array
-- TODO: change type to `DIM2 :~> Cell`
createCell :: DIM2 :~> Word8
createCell = uniformR (0, 6)

createWorld :: DIM2 -> P.IO World
createWorld = randomArray createCell

cellStencil :: Stencil3x3 Word8 -> Exp Word8
cellStencil ((ul, uc, ur), (cl, cur, cr), (dl, dc, dr)) =
  --   (uc == next || cl == next || (cr == next && dc == next))
  next_cnt >= 2
    ? ( next,
        cur -- prev_cnt >= 2 ? (prev, cur)
      )
  where
    next = (cur + 1) `mod` 7
    next' = (next + 1) `mod` 7
    prev = (cur + 7 - 1) `mod` 7
    next_cnt :: Exp Word8
    next_cnt =
      (ul == next ? (1, 0))
        + (uc == next ? (1, 0))
        + (ur == next ? (1, 0))
        + (cl == next ? (1, 0))
        + (cr == next ? (1, 0))
        + (dl == next ? (1, 0))
        + (dc == next ? (1, 0))
        + (dr == next ? (1, 0))
    next_cnt' :: Exp Word8
    next_cnt' =
      --   (ul == next ? (1, 0))
      (uc == next' ? (1, 0))
        -- + (ur == next ? (1, 0))
        + (cl == next' ? (1, 0))
        + (cr == next' ? (1, 0))
        -- + (dl == next ? (1, 0))
        + (dc == next' ? (1, 0))
    -- + (dr == next ? (1, 0))
    prev_cnt :: Exp Word8
    prev_cnt =
      (ul == prev ? (1, 0))
        + (uc == prev ? (1, 0))
        + (ur == prev ? (1, 0))
        + (cl == prev ? (1, 0))
        + (cr == prev ? (1, 0))
        + (dl == prev ? (1, 0))
        + (dc == prev ? (1, 0))
        + (dr == prev ? (1, 0))

updateWorld :: Acc World -> Acc World
updateWorld = stencil cellStencil wrap
