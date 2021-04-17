module Server.App
  ( app
  , App
  ) where

import Type.Proxy (Proxy(..))
import Type.Trout (Resource)
import Type.Trout.Method (Get)
import Type.Trout.ContentType.HTML (HTML)

import Server.App.Home (Home)

type App = Resource (Get Home HTML)

app :: Proxy App
app = Proxy

