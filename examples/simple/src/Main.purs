module Main where

import Prelude

import Color (Color, black, graytone, white)
import Data.Function (on)
import Data.Int (toNumber)
import Data.Vec (vec2)
import Effect (Effect)
import P5.Canvas (background, createCanvas, fill, stroke)
import P5.D2 (Angle(..), arc)
import P5.Environment (frameCount, windowHeight, windowSize, windowWidth)
import P5.Monad (draw, runP5, setup)

scale :: forall f x. Functor f => Semiring x => x -> f x -> f x
scale x v = (*) x <$> v

bgcol :: Color
bgcol = graytone 0.22

main :: Effect Unit
main = do
  runP5 do
    ww <- windowWidth
    wh <- windowHeight
    ws <- map toNumber <$> windowSize
    setup do
      createCanvas ww wh
    draw do
      f <- frameCount
      background bgcol
      fill white
      stroke black
      arc (scale 0.5 $ (on vec2 toNumber) ww wh) (vec2 100.0 100.0) (Radians 0.0) (Degrees (toNumber f))