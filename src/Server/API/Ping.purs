module Server.API.Ping
  ( Ping
  , pingResource
  ) where

import Prelude

import Control.Monad.Except (ExceptT)

import Hyper.Trout.Router (RoutingError)

type Ping = { message :: String }

pingResource :: forall m. Monad m => { "GET" :: ExceptT RoutingError m Ping }
pingResource = { "GET": pure $ { message: "pong!" } }
