{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module CCA.Types where

import Data.Array.Accelerate
import qualified Prelude as P

type World = Matrix Word8

-- newtype Cell = Cell Word8
--   deriving (Generic, Elt)

-- -- | Fix and change to Accelerate analog
-- instance P.Bounded Cell where
--   minBound = Cell 0
--   maxBound = Cell 6
