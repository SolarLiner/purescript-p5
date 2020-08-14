-- | Module containing actions that manipulate the canvas.
module P5.Canvas where

import Prelude

import Color (Color, toRGBA)
import Control.Monad.Reader (ask)
import Data.Function (on)
import Data.Int (toNumber)
import P5.Monad (P5)
import P5.Unsafe.Canvas as UC
  
-- | Creates a canvas element in the document, and sets the dimensions of it in pixels.
-- | This method should be called only once at the start of setup.
-- |
-- | Calling `createCanvas` more than once in a sketch will result in very unpredictable behavior.
-- |
-- | TODO: Add `createGraphics`
-- |
-- | The `width` and `height` values are set by the parameters passed to this function.
-- | If `createCanvas` is not called, then a canvas of 100x100 will be created.
createCanvas :: Int -> Int -> P5 Unit
createCanvas w h = on UC.createCanvas toNumber w h <$> ask

-- | Removes the default canvas of the sketch when it is not needed.
noCanvas :: P5 Unit
noCanvas = UC.noCanvas <$> ask

-- | This function sets the colour used for the background of the canvas.
-- | The default background is transparent. This function is typically used within `draw` to
-- | clear the display, but can also be called from `setup` to set the background once for
-- | the whole animation.
background :: Color -> P5 Unit
background col = UC.background (toNumber r) (toNumber g) (toNumber b) (a*255.0) <$> ask
  where
    {r,g,b,a} = toRGBA col

-- | Disables drawing the stroke (outline).
noStroke :: P5 Unit
noStroke = UC.noStroke <$> ask

-- | Sets the color used to draw lines and borders around shapes.
stroke :: Color -> P5 Unit
stroke col = UC.stroke (toNumber r) (toNumber g) (toNumber b) (a * 255.0)  <$> ask
  where
    { r,g,b,a } = toRGBA col

-- | Sets the width of the stroke used for lines, points and the border around
-- | shapes. All widths are set in units of pixels.
strokeWeight :: Number -> P5 Unit
strokeWeight w = UC.strokeWeight w <$> ask

-- | Disables filling geometry.
noFill :: P5 Unit
noFill = UC.noFill <$> ask

-- | Sets the color used to fill shapes.
fill :: Color -> P5 Unit
fill col = UC.fill (toNumber r) (toNumber g) (toNumber b) (a * 255.0) <$> ask
  where
    { r,g,b,a } = toRGBA col

-- | Clears the pixels within a buffer. This function only clears the canvas;
-- | it will not free any resources that might have been created, for examples by calls
-- | tp `createVideo` or `createDiv`.
-- |
-- | This function makes all pixels 100% transparent.
clear :: P5 Unit
clear = UC.clear <$> ask