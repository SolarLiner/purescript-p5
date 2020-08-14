-- | Module containing drawing actions.
module P5.D2 (V2, Angle(..), CloseMode(..), radians, degrees, arc, arc', line) where

import Prelude

import Control.Monad.Reader (ask)
import Data.Typelevel.Num (D2, d0, d1)
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

foreign import data RawCloseMode :: Type
foreign import arcImpl :: Number -> Number -> Number -> Number -> Number -> Number -> RawCloseMode -> P5JS -> Unit
foreign import lineImpl :: Number -> Number -> Number -> Number -> P5JS -> Unit