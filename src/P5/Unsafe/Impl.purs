module P5.Unsafe.Impl where


import Data.Unit (Unit)
import Effect (Effect)
import P5.Unsafe.Types (P5JS)


foreign import runP5Impl :: (P5JS -> Effect Unit) -> Effect P5JS
foreign import addFn :: String -> (P5JS -> Effect Unit) -> P5JS -> Effect Unit
foreign import getValue :: forall a. String -> P5JS -> a
foreign import setValue :: forall a. String -> a -> P5JS -> Unit

