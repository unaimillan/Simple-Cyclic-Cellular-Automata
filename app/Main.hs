{-# LANGUAGE CPP #-}

-- |
-- Module      : Main
-- Copyright   : [2021] Author name here
-- License     : BSD3
--
-- Maintainer  : Author name here <example@example.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
module Main where

import CCA
import Control.Exception (evaluate)
import Data.Array.Accelerate as A
import qualified Graphics.Gloss as GL
import Graphics.Gloss.Data.Color (black)
import Lib
import Text.Printf
import Prelude as P

#ifdef ACCELERATE_LLVM_NATIVE_BACKEND
import Data.Array.Accelerate.LLVM.Native                            as CPU
#endif
#ifdef ACCELERATE_LLVM_PTX_BACKEND
import Data.Array.Accelerate.LLVM.PTX                               as PTX
#endif

worldWidth :: Int
worldWidth = 500

worldHeight :: Int
worldHeight = worldWidth

-- initialWorld :: World
-- initialWorld = undefined

-- handleWorld :: Event -> World -> World
-- handleWorld _ = P.id

-- #ifdef ACCELERATE_LLVM_PTX_BACKEND
-- run1 = PTX.run1
-- #endif
-- #ifdef ACCELERATE_LLVM_NATIVE_BACKEND
-- run1 = CPU.run1
-- #endif

main :: IO ()
main =
  do
    let -- visualisation configuration
        n = worldWidth
        zoom = 2
        fps = 25

        dish = Z :. n :. n
        width = n * zoom
        height = n * zoom

        -- backend = get optBackend opts

        render =
          draw zoom
            . CPU.run1 (colourise)
        update = CPU.run1 updateWorld
    -- advance = Main.run1 (smoothlife conf opts)

    -- initialise with patches of random data
    -- dots <- randomCircles dish ra rb
    -- agar <- randomArray (splat dots) dish
    -- world <- evaluate (advance agar)

    wrld <- createWorld dish
    world <- evaluate wrld

    GL.simulate
      (GL.InWindow "Cyclic Cellular Automata" (width, height) (10, 20))
      black
      fps
      world
      render
      (\_ _dt -> update)

oldMain :: IO ()
oldMain = do
  let xs :: Vector Double
      xs = fromList (Z :. 10) [0 ..]

      ys :: Vector Double
      ys = fromList (Z :. 10) [1, 3 ..]

  printf "input data:\n"
  printf "xs = %s\n" (show xs)
  printf "ys = %s\n\n" (show ys)

  printf "the function to execute:\n"
  printf "%s\n\n" (show dotp)

#ifdef ACCELERATE_LLVM_NATIVE_BACKEND
  printf "result with CPU backend: dotp xs ys = %s\n" (show (CPU.runN dotp xs ys))
#endif
#ifdef ACCELERATE_LLVM_PTX_BACKEND
  printf "result with PTX backend: dotp xs ys = %s\n" (show (PTX.runN dotp xs ys))
#endif
