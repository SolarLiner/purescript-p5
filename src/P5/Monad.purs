-- | The P5 Monad is at the heart of this wrapper. It allows passing the p5
-- | parameter implicitely, while also allowing an imperative style.
module P5.Monad where

import Prelude

import Control.Monad.Reader (ReaderT(..), runReaderT)
import Effect (Effect)
import P5.Unsafe.Impl (addFn, runP5Impl)
import P5.Unsafe.Types (P5JS)
  
-- | P5 Monad Transformer.
type P5T = ReaderT P5JS
-- | P5 Monad Transformer applied to the Effect monad. This type is used
-- | throughout the library to prevent usage of p5 functions outside of
-- |`Effect`, as the  original `p5.js` functions contain arbitrary side-effecs.
type P5 = P5T Effect

-- | Run the `P5` monad into the `Effect` monad.
runP5 :: P5 Unit -> Effect Unit
runP5 runner = do
  let _ = runP5Impl $ runReaderT runner
  pure unit

-- | Lift actions to be done at setup
setup :: P5 Unit -> P5 Unit
setup p = ReaderT $ addFn "setup" (runReaderT p)

-- | Lift actions to be done every frame
draw :: P5 Unit -> P5 Unit
draw p = ReaderT $ addFn "draw" (runReaderT p)

-- | Lift actions to be done before p5 finishies initializing.
preload :: P5 Unit -> P5 Unit
preload p = ReaderT $ addFn "preload" (runReaderT p)
