module P5.Unsafe.Canvas where

import Prelude

import P5.Unsafe.Types (P5JS)

foreign import createCanvas :: Number -> Number -> P5JS -> Unit
foreign import resizeCanvas :: Number -> Number -> P5JS -> Unit
foreign import noCanvas :: P5JS -> Unit
foreign import background :: Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import noStroke :: P5JS -> Unit
foreign import stroke :: Number -> Number -> Number -> Number -> P5JS -> Unit
foreign import strokeWeight :: Number -> P5JS -> Unit
foreign import noFill :: P5JS -> Unit
foreign import fill :: Number -> Number -> Number -> Number-> P5JS -> Unit
foreign import clear :: P5JS -> Unit