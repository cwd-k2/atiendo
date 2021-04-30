module Atiendo.Types
  ( PingMessage(..)
  ) where

import Foreign.Class (class Encode)
import Foreign.Generic (defaultOptions, genericEncode)

import Data.Generic.Rep (class Generic)

newtype PingMessage = PingMessage { message :: String }

derive instance genericPingMessage :: Generic PingMessage _

instance encodePingMessage :: Encode PingMessage where
  encode = genericEncode defaultOptions { unwrapSingleConstructors = true }

