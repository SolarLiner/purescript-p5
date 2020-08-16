module Main where

import Prelude

import Color (Color, black, graytone, hsv, white)
import Control.Monad.Trans.Class (lift)
import Data.Array (range)
import Data.Foldable (class Foldable, foldr)
import Data.Function (on)
import Data.Int (Parity(..), floor, parity, toNumber)
import Data.Traversable (traverse)
import Data.Typelevel.Num (d0, d1)
import Data.Vec (index, vec2)
import Effect (Effect)
import Effect.Random (random, randomRange)
import Effect.Ref as Ref
import Math ((%), sin)
import P5.Canvas (background, createCanvas, fill, noStroke, stroke, strokeWeight)
import P5.D2 (Angle(..), V2, arc, circle, radians, point)
import P5.Environment (frameCount, windowHeight, windowSize, windowWidth)
import P5.Monad (P5, draw, runP5, setup)

mapM_ :: forall t m a b. Foldable t => Monad m => (a -> m b) -> t a -> m Unit
mapM_ f = foldr c (pure unit)
  where
    c x k = f x >>= const k

scale :: forall f x. Functor f => Semiring x => x -> f x -> f x
scale x v = (*) x <$> v

bgcol :: Color
bgcol = graytone 0.22

renderPoints :: Array V2 -> P5 Unit
renderPoints ps = do
  strokeWeight 5.0
  mapM_ point ps

checkBounds :: V2 -> V2 -> Boolean
checkBounds s p = x >= 0.0 && x < w && y >= 0.0 && y < h
  where
    x = index p d0
    y = index p d1
    w = index s d0
    h = index s d1

createPoints :: Number -> Number -> Effect (Array V2)
createPoints w h = traverse (const newPoint) $ range 1 10
  where
    newPoint :: Effect V2
    newPoint = vec2 <$> randomRange 0.0 w <*> randomRange 0.0 h

main :: Effect Unit
main = do
  runP5 do
    ww <- windowWidth
    wh <- windowHeight
    ws <- map toNumber <$> windowSize
    _pts <- on createPoints toNumber ww wh
    ptsRef <- lift $ Ref.new _pts
    let center = scale 0.5 $ (on vec2 toNumber) ww wh
    let size = vec2 100.0 100.0
    setup do
      createCanvas ww wh
    draw do
      f <- flip (%) 720.0 <<< toNumber <$> frameCount
      let s = parity $ floor (f/360.0)
      let empty = f <= 1e-3
      -- background
      background bgcol
      -- background circle
      noStroke
      fill $ hsv f 0.2 0.4
      circle center (100.0 * (2.0 + (sin $ radians (Degrees f))))
      -- background dots
      pts <- lift $ Ref.read ptsRef
      renderPoints pts
      -- animated pie
      fill white
      stroke black
      if not empty
      then case s of
        Even -> arc center size (Radians 0.0) (Degrees f)
        Odd  -> arc center size (Degrees  f) (Radians 0.0)
      else pure unit