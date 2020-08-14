-- | This module hosts an enumerated type for supported blending modes
-- | in p5.js;
module P5.BlendModes (BlendMode(..), blendMode) where

import Prelude

import Control.Monad.Reader (ask)
import P5.Monad (P5)
import P5.Unsafe.Impl as UI
import P5.Unsafe.Types (P5JS)

-- | Type of allowed blending modes.
data BlendMode
  -- | Linear interpolation of colours: `C = A * factor + B`.
    = Blend
    -- | Sum of A and B
    | Add
    -- | Only the darkest colour succeeds: `C = min(A * factor, B)`
    | Darkest
    -- | Only the lightest colour succeeds: `C = max(A * factor, B)`
    | Lightest
    -- | Subtract colors from the underlying buffer
    | Difference
    -- | Similar to `Difference`, but less extreme.
    | Exclusion
    -- | Multiply the colours; the result will always be darker.
    | Multiply
    -- | Opposite multiply, uses inverses of the colours.
    | Screen
    -- | Newly added pixels simply overwrite the existing one, without alpha-blending.
    | Replace
    -- | Remove pixels from B with the alpha strength of A.
    | Remove
    -- | A mix of `Multiply` and `Screen`. Multiplies dark values, and screens light values.
    | Overlay
    -- | `Screen` with greater than 50% gray, `Multiply` when lower.
    | HardLight
    -- | Mix of `Darkest` and `Lightest`. Works like `Overlay`, but not as harsh.
    | SoftLight
    -- | Lightens bright tons and increases contrase, ignores darks.
    | Dodge
    -- | Darker areas are applied, increasing contrast, ignores lights.
    | Burn

derive instance eqBlendMode :: Eq BlendMode
instance showBlendMode :: Show BlendMode where
  show Blend = "BLEND"
  show Add = "ADD"
  show Darkest = "DARKEST"
  show Lightest = "LIGHTEST"
  show Difference = "DIFFERENCE"
  show Exclusion = "EXCLUSION"
  show Multiply = "MULTIPLY"
  show Screen = "SCREEN"
  show Replace = "REPLACE"
  show Remove = "REMOVE"
  show Overlay = "OVERLAY"
  show HardLight = "HARD_LIGHT"
  show SoftLight = "SOFT_LIGHT"
  show Dodge = "DODGE"
  show Burn = "BURN"

blendModeValue :: BlendMode -> P5 RawBlendMode
blendModeValue bm = UI.getValue (show bm) <$> ask

-- | Set the blend mode for the p5 sketch.
blendMode :: BlendMode -> P5 Unit
blendMode bm = do
  v <- blendModeValue bm
  blendModeImpl v <$> ask
foreign import data RawBlendMode :: Type
foreign import blendModeImpl :: RawBlendMode -> P5JS -> Unit