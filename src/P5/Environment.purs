-- | This module contains P5 actions getting or setting the environment.
module P5.Environment where

import Prelude

import Control.Monad.Reader (ask)
import Data.Int (fromNumber)
import Data.Maybe (fromJust)
import Data.Typelevel.Num (D2)
import Data.Vec (Vec, vec2)
import P5.Monad (P5)
import P5.Unsafe.Environment as UE
import Partial.Unsafe (unsafePartial)

-- | Sets the sketch to fullscreen or not, depending on the value of the first argument.
-- |
-- | Note that due to browser restrictions this an only be called on use input; for example
-- | on mouse press.
fullscreen :: Boolean -> P5 Unit
fullscreen b = UE.fullscreen b <$> ask

-- | Width of the canvas, as given by the call to `createCanvas`.
width :: P5 Int
width = num2int <<< UE.width <$> ask

-- | Height of the canvas, as given by the call to `createCanvas`.
height :: P5 Int
height = num2int <<< UE.height <$> ask

-- | Size vector of the canvas, as given by the call to `createCanvas`.
size :: P5 (Vec D2 Int)
size = vec2 <$> width <*> height

-- | Returns the current fullscreen state.
isFullscreen :: P5 Boolean
isFullscreen = UE.isFullscreen <$> ask

-- | Width of the inner window; as returned by `window.innerWidth`.
windowWidth :: P5 Int
windowWidth = num2int <<< UE.windowWidth <$> ask

-- | Height of the inner window; as returned by `window.innerHeight`.
windowHeight :: P5 Int
windowHeight = num2int <<< UE.windowHeight <$> ask

-- | Size vector of the inner window.
windowSize :: P5 (Vec D2 Int)
windowSize = vec2 <$> windowWidth <*> windowHeight

-- | Width of the display according to the default `pixelDensity`.
-- | In order to get the actual screen size, multiply it by `pixelDensity`.`
displayWidth :: P5 Int
displayWidth = num2int <<< UE.displayWidth <$> ask

-- | Height of the display according to the default `pixelDensity`.
-- | In order to get the actual screen size, multiply it by `pixelDensity`.
displayHeight :: P5 Int
displayHeight = num2int <<< UE.displayHeight <$> ask

-- | Size vector of the display according to the default `pixelDensity`.
-- | In order to get the actual screen size, multiply it by `pixelDensity`.
displaySize :: P5 (Vec D2 Int)
displaySize = vec2 <$> displayWidth <*> displayHeight

-- | Count of frames that have been displayed since the program started.
-- | Inside `setup` the value is 0; after the first iteration it is incremented to 1, etc.
frameCount :: P5 Int
frameCount = num2int <<< UE.frameCount <$> ask

-- | Number of frames to be displayed every second. The draw function must run
-- | at least once to return sane values.
frameRate :: P5 Number
frameRate = UE.getFrameRate <$> ask

-- | Sets the number of frames to be displayed every second. If ths processor is not
-- | fast enough to maintain the specific rate, the frame rate will not be achieved.
-- |
-- | Setting this value within `setup` is recommended.
setFrameRate :: Number -> P5 Unit
setFrameRate n = UE.setFrameRate n <$> ask

-- | Difference in time between the beginning of the previous frame and the beginning of the current one.
-- | Value is in milliseconds.
deltaTime ::  P5 Number
deltaTime = UE.deltaTime <$> ask

num2int :: Number -> Int
num2int = unsafePartial (fromJust <<< fromNumber)