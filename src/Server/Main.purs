module Server.Main where

import Prelude

import Effect (Effect)

import Control.Monad.Indexed ((:*>))

import Data.Maybe (maybe)

import Data.MediaType.Common (textHTML)

import Type.Proxy (Proxy(..))

import Hyper.Response (closeHeaders, contentType, respond, writeStatus)
import Hyper.Status (statusNotFound)

import Hyper.Node.Server (defaultOptionsWithLogging, runServer)
import Hyper.Node.FileServer (fileServer)

import Hyper.Trout.Router (router)

import Type.Trout (type (:=), type (:/), type (:<|>))

import Server.Web (Web, webResources)
import Server.API (API, apiResources)

type App = "web" := Web :<|> "api" := "api" :/ API

app :: Proxy App
app = Proxy

main :: Effect Unit
main = do
  runServer defaultOptionsWithLogging {} mainRouter
  where
    mainRouter = router app resources fallbackRouter

    resources =
      { "web": webResources
      , "api": apiResources
      }

    notFound =
      writeStatus statusNotFound
      :*> contentType textHTML
      :*> closeHeaders
      :*> respond "Not Found"

    fallbackRouter stat msg
      | stat == statusNotFound = fileServer "public" notFound
      | otherwise =
        writeStatus stat
        :*> contentType textHTML
        :*> closeHeaders
        :*> respond (maybe "" identity msg)
