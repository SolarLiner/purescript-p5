-- | Module containing drawing actions.
module P5.D2 (V2,
  Angle(..),
  CloseMode(..),
  radians,
  degrees,
  arc,
  arc',
  line,
  ellipse,
  circle,
  quad,
  point,
  triangle,
  square,
  squareRounded,
  squareRounded',
  rect,
  rectRounded,
  rectRounded') where

import Prelude

import Control.Monad.Reader (ask)
import Data.Typelevel.Num (D2, D3, D4, d0, d1, d2, d3)
import Data.Vec (Vec, index)
import Math (pi)
import P5.Monad (P5)
import P5.Unsafe.Impl as UI
import P5.Unsafe.Types (P5JS)

-- | Type definition for simplifying writing Vector2 types.
type V2 = Vec D2 Number

-- | Angle type, containing either degrees or radians.
data Angle = Degrees Number | Radians Number

instance eqAngle :: Eq Angle where
  eq (Degrees l) (Degrees r) = l == r
  eq (Radians l) (Radians r) = l == r
  eq l r = radians l == radians r

-- | Arc closing mode.
data CloseMode = Open | Chord | Pie

derive instance eqCloseMode :: Eq CloseMode
instance showCloseMode :: Show CloseMode where
  show Open = "OPEN"
  show Chord = "CHORD"
  show Pie = "PIE"

-- | Convert an angle to radians. This can be used to exctract an `Angle` to a number.
radians :: Angle -> Number
radians (Radians r) = r
radians (Degrees d) = d * pi / 180.0

-- | Convert an angle to degrees. This can be used to extract an `Angle` to a number.
degrees :: Angle -> Number
degrees (Degrees d) = d
degrees (Radians r) = r * 180.0 / pi

-- | Draw an arc to the screen.
-- |
-- | The arc is always drawn clockwise from wherever start falls to wherever stop falls
-- | on the ellipse. Adding or subtracting `Degrees 360.0` does not change where they call.
-- | If both start an stop angles are the same, then a full ellipse is drawn.
-- |
-- | Be aware that the Y axis increases in the downward direction, therefore angles are
-- | measured clobkwise from the positive x-direction ("3 o'clock").
arc :: V2 -> V2 -> Angle -> Angle -> P5 Unit
arc p s st e = arc' p s st e Pie

-- | Draw an arc to the screen with a specified clowing mode.
-- |
-- | The arc is always drawn clockwise from wherever start falls to wherever stop falls
-- | on the ellipse. Adding or subtracting `Degrees 360.0` does not change where they call.
-- | If both start an stop angles are the same, then a full ellipse is drawn.
-- |
-- | Be aware that the Y axis increases in the downward direction, therefore angles are
-- | measured clobkwise from the positive x-direction ("3 o'clock").
arc' :: V2 -> V2 -> Angle -> Angle -> CloseMode -> P5 Unit
arc' p s st e cm = do
  closeMode <- UI.getValue (show cm) <$> ask
  arcImpl x y w h (radians st) (radians e) closeMode <$> ask
  where
    x = index p d0
    y = index p d1
    w = index s d0
    h = index s d1

-- | Draws a line (a direct path between two points) to the screen.
line :: V2 -> V2 -> P5 Unit
line s e = lineImpl x1 y1 x2 y2 <$> ask
  where
    x1 = index s d0
    y1 = index s d1
    x2 = index e d0
    y2 = index e d1

-- | Draws an ellipse (oval) to the screen. First parameter is the position vector, 
-- | the second one is the size vector, where absolute values are taken in case negative
-- | numbers are passed in.
-- |
-- | For a version that only take a scalar size parameter, see `circle`.
ellipse :: V2 -> V2 -> P5 Unit
ellipse p s = ellipseImpl x y w h <$> ask
  where
    x = index p d0
    y = index p d1
    w = index s d0
    h = index s d1

-- | Draws a circle to the screen. A circle is a simple closed shape. It is the set of
-- | all points in a plane that are at a given distance from a given point, the centre.
-- | This function is a special case of the `ellipse` function where the width and height
-- | of the ellipse are the same.
circle :: V2 -> Number -> P5 Unit
circle p d = circleImpl x y d <$> ask
  where
    x = index p d0
    y = index p d1

-- | Draws a point, a coordinate in space at the dimension of one pixel. The input
-- | vector represents the position of the point (the center of the dot drawn on screen)
-- | 
-- | Drawing a point uses a stroke, therefore color is controlled by `stroke` and the
-- | diameter by `strokeWeight`.
point :: V2 -> P5 Unit
point p = pointImpl x y <$> ask
  where
    x = index p d0
    y = index p d1

-- | Draws a quad on the canvas. A quad is a quadrilateral, a four-sided polygon.
-- | It is similar to a rectangle, but the angles bewteen its edges are not constrained
-- | to right andles.
-- | The parameter is a 4-dimensional vector of 2D vectors, representing each vertex of
-- | the quad.
-- |
-- | Example:
-- |
-- | ```purescript
-- | -- Draws the unit square
-- | quad (vec 2 0.0 0.0) +> (vec2 0.0 1.0) +> (vec2 1.0 1.0) +> singleton (vec2 1.0 0.0)
-- | ```
quad :: Vec D4 V2 -> P5 Unit
quad v = quadImpl x1 y1 x2 y2 x3 y3 x4 y4 <$> ask
  where
    x1 = index (index v d0) d0
    y1 = index (index v d0) d1
    x2 = index (index v d1) d0
    y2 = index (index v d1) d1
    x3 = index (index v d2) d0
    y3 = index (index v d2) d1
    x4 = index (index v d3) d0
    y4 = index (index v d3) d1

-- | Draws a triangle to the canvas. A triangle is a plane created by connecting three points.
-- | The argument is a 3-dimensional vector of 2D vectors
triangle :: Vec D3 V2 -> P5 Unit
triangle v = triangleImpl x1 y1 x2 y2 x3 y3 <$> ask
  where
    x1 = index (index v d0) d0
    y1 = index (index v d0) d1
    x2 = index (index v d1) d0
    y2 = index (index v d1) d1
    x3 = index (index v d2) d0
    y3 = index (index v d2) d1

-- | Draws a square to the screen. A square is a four-sided shape with every angle at
-- | ninety degrees, and equal size. This function is a special case of `rect` where
-- | both sizes are the same.
-- | The first parameter is either the top-left or the center of the square (depending on
-- | `rectMode`), and the second is the size length.
square :: V2 -> Number -> P5 Unit
square p d = squareImpl x y d <$> ask
  where
    x = index p d0
    y = index p d1

-- | Draws a rounded square to the screen. This action is similar to `square` except
-- | it also rounds the square with a radius given by the last parameter.
squareRounded :: V2 -> Number -> Number -> P5 Unit
squareRounded p d r = squareRounded' p d r r r r

-- | Variant of `squareRounded` where each corner radius is given separatedly, going
-- | clockwise from the top left.
squareRounded' :: V2 -> Number -> Number -> Number -> Number -> Number -> P5 Unit
squareRounded' p d rtl rtr rbr rbl = squareRoundedImpl x y d rtl rtr rbr rbl <$> ask
  where
    x = index p d0
    y = index p d1    

-- | Draws a rectandle on the canvas. A rectangle is a four-sidd closed shape with every angle
-- | at ninety degrees. The first vector parameter specifies either the top-left or the center of the
-- | rectangle (depending on `rectMode`), whereas the second vector parameter specifies the size.
rect :: V2 -> V2 -> P5 Unit
rect p s = rectImpl x y w h <$> ask
  where
    x = index p d0
    y = index p d1
    w = index s d0
    h = index s d1

-- | Draws a rounded rectangle on the canvas. This is a similar action to `rect`, with the added last
-- | parameter which controls the corner radius.
rectRounded :: V2 -> V2 -> Number -> P5 Unit
rectRounded p s r = rectRounded' p s r r r r

-- | Draws a rounded rectangle on the canvas. This is a similar action to `rectRounded`, except control
-- | is given on the corner radius of each corner going clockwise from the top left.
rectRounded' :: V2 -> V2 -> Number -> Number -> Number -> Number -> P5 Unit
rectRounded' p s rtl rtr rbr rbl = rectRoundedImpl x y w h rtl rtr rbr rbl <$> ask
  where
    x = index p d0
    y = index p d1
    w = index s d0
    h = index s d1

foreign import data RawCloseMode :: Type
foreign import arcImpl :: Number -> Number -> Number -> Number -> Number -> Number -> RawCloseMode -> P5JS -> Unit
foreign import lineImpl :: Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import ellipseImpl :: Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import circleImpl :: Number -> Number -> Number -> P5JS -> Unit
foreign import pointImpl :: Number -> Number -> P5JS -> Unit
foreign import quadImpl :: Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import triangleImpl :: Number -> Number -> Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import squareImpl :: Number -> Number -> Number -> P5JS -> Unit
foreign import squareRoundedImpl :: Number -> Number -> Number -> Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import rectImpl :: Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import rectRoundedImpl :: Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> P5JS -> Unit