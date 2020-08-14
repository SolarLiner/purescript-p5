module P5.Unsafe.Environment where

import Prelude

import P5.Unsafe.Impl as UI
import P5.Unsafe.Types (P5JS)

width :: P5JS -> Number
width = UI.getValue "width"

height :: P5JS -> Number
height = UI.getValue "height"

windowWidth :: P5JS -> Number
windowWidth = UI.getValue "windowWidth"

windowHeight :: P5JS -> Number
windowHeight = UI.getValue "windowHeight"

displayWidth :: P5JS -> Number
displayWidth = UI.getValue "displayWidth"

displayHeight :: P5JS -> Number
displayHeight = UI.getValue "displayHeight"

frameCount :: P5JS -> Number
frameCount = UI.getValue "frameCount"

deltaTime :: P5JS -> Number
deltaTime = UI.getValue "deltaTime"

foreign import fullscreen :: Boolean -> P5JS -> Unit
foreign import isFullscreen :: P5JS -> Boolean
foreign import getFrameRate :: P5JS -> Number
foreign import setFrameRate :: Number -> P5JS -> Unit