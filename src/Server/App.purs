module Server.App
  ( app
  , notFound
  , appRouter
  , App
  ) where

import Prelude

import Effect.Aff.Class (class MonadAff)

import Control.Monad.Indexed ((:*>))

import Data.Maybe (maybe)

import Node.Buffer (Buffer)

import Data.MediaType.Common (textHTML)

import Hyper.Status (statusNotFound)
import Hyper.Middleware (Middleware)
import Hyper.Conn (Conn)
import Hyper.Request (class Request)
import Hyper.Response ( closeHeaders, contentType, respond, writeStatus
                      , StatusLineOpen, ResponseEnded
                      , class Response, class ResponseWritable
                      )

import Hyper.Node.FileServer (fileServer)

import Hyper.Trout.Router (router)

import Type.Proxy (Proxy(..))
import Type.Trout (type (:=), Resource)
import Type.Trout.Method (Get)
import Type.Trout.ContentType.HTML (HTML)

import Server.App.Home (Home, homeResource)

type App =
       "home" := Resource (Get Home HTML)

app :: Proxy App
app = Proxy

notFound :: forall m req res c b
  .  Monad m
  => Response res m b
  => ResponseWritable b m String
  => Middleware
     m
     (Conn req (res StatusLineOpen) c)
     (Conn req (res ResponseEnded) c)
     Unit
notFound =
  writeStatus statusNotFound
  :*> contentType textHTML
  :*> closeHeaders
  :*> respond "Not Found"

appRouter :: forall m req res c b
  .  Monad m
  => MonadAff m
  => Request req m
  => Response res m b
  => ResponseWritable b m Buffer
  => ResponseWritable b m String
  => Middleware
     m
     (Conn req (res StatusLineOpen) c)
     (Conn req (res ResponseEnded) c)
     Unit
appRouter = router app resources fallbackRouter
  where
    resources = { home: homeResource
                }

    fallbackRouter stat msg
      | stat == statusNotFound = fileServer "public" notFound
      | otherwise =
        writeStatus stat
        :*> contentType textHTML
        :*> closeHeaders
        :*> respond (maybe "" identity msg)
