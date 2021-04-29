{-# LANGUAGE FlexibleContexts #-}

module CCA.Draw where

import CCA.Types
import Data.Array.Accelerate as A hiding (size)
import Data.Array.Accelerate.Data.Colour.Names
import Data.Array.Accelerate.Data.Colour.RGB
import Graphics.Gloss (Picture, blank, scale)
import Graphics.Gloss.Accelerate.Data.Picture
import qualified Prelude as P

type RGBA32 = Word32

-- | Cyclic rainbow colors
-- Red
-- Orange
-- Yellow
-- Green
-- Blue
-- Indigo
-- Violet
colour :: Exp Word8 -> Exp Colour
colour v =
  v == 0
    ? ( red,
        v == 1
          ? ( orange,
              v == 2
                ? ( yellow,
                    v == 3
                      ? ( green,
                          v == 4
                            ? ( blue,
                                v == 5
                                  ? ( indigo,
                                      v == 6
                                        ? ( violet,
                                            white
                                          )
                                    )
                              )
                        )
                  )
            )
      )

-- colour 1 = orange
-- colour 2 = yellow
-- colour 3 = green
-- colour 4 = blue
-- colour 5 = indigo
-- colour 6 = violet
-- colour _ = white

colourise :: Acc World -> Acc (Matrix RGBA32)
colourise = A.map (packRGB . colour)

draw :: Int -> Matrix RGBA32 -> Picture
draw zm arr = scale zoom zoom pic
  where
    zoom = P.fromIntegral zm
    pic = bitmapOfArray arr False

drawWorld :: World -> Picture
drawWorld _world = blank
