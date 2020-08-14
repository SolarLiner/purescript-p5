-- | This module handles setting renderer attributes in P5.js. Instead of passing strings,
-- | type-safety is introuced by using an enumerated type.
module P5.Attributes (Attribute(..), setAttribute) where

import Prelude

import Control.Monad.Reader (ask)
import P5.Monad (P5)
import P5.Unsafe.Types (P5JS)

-- | Type of allowed attributes to p5.setAttributes.
data Attribute
    -- | Indicates whether the canvas contains an alpha buffer
    = Alpha
    -- | Indicates whether the drawing buffer has a depth of at least 16 bits
    | Depth
    -- | Indicates whether the drawing buffer has a stencil buffer of at least 8 bits
    | Stencil
    -- | Indicates whether or not to perform anti-aliasing
    | Antialias
    -- | Indicates that the page compositor will assume the drawing buffer contains colors with pre-multiplied alpha
    | PremultipliedAlpha
    -- | If `true`, the buffers will not be cleared and will preserve their values until cleared or overwritten by author
    | PreserveDrawingBuffer
    -- | If `true`, pe-pixel lighting will be used in the lighting shader, otherwise per-vertex lighting is used
    | PerPixelLighting

derive instance eqAttribute :: Eq Attribute
instance showAttribute :: Show Attribute where
  show a = attributeKey a

attributeKey :: Attribute -> String
attributeKey (Alpha) = "alpha"
attributeKey (Depth) = "depth"
attributeKey (Stencil) = "stencil"
attributeKey (Antialias) = "antialias"
attributeKey (PremultipliedAlpha) = "premultipliedAlpha"
attributeKey (PreserveDrawingBuffer) = "preserveDrawingBuffer"
attributeKey (PerPixelLighting) = "perPixelLighting"

-- | Set a p5.js attribute (in)active.
setAttribute :: Attribute -> Boolean -> P5 Unit
setAttribute a b = setAttributeImpl (attributeKey a) b <$> ask

foreign import setAttributeImpl :: forall a. String -> a -> P5JS -> Unit
