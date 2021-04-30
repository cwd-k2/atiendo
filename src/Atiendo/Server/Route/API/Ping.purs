module Atiendo.Server.Route.API.Ping
  ( pingHandler
  ) where

import Prelude

import Foreign.Generic (encodeJSON)

import Node.Express.Handler (Handler)
import Node.Express.Response (send)

import Atiendo.Types (PingMessage(..))

pingHandler :: Handler
pingHandler = send <<< encodeJSON $ PingMessage { message: "Pong!" }
