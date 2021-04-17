module Server.Main where

import Prelude

import Effect (Effect)

import Control.Monad.Indexed.Qualified as Ix

import Data.Maybe (maybe)
import Data.MediaType.Common (textHTML)

import Hyper.Node.Server (defaultOptionsWithLogging, runServer)
import Hyper.Node.FileServer (fileServer)
import Hyper.Status (statusNotFound)
import Hyper.Middleware (Middleware)
import Hyper.Conn (Conn)
import Hyper.Response ( closeHeaders, contentType, respond, writeStatus
                      , StatusLineOpen, ResponseEnded
                      , class Response, class ResponseWritable
                      )

import Hyper.Trout.Router (router)

import Server.App (app)
import Server.App.Home (home)

notFound :: forall m req res c b
  .  Monad m
  => Response res m b
  => ResponseWritable b m String
  => Middleware m (Conn req (res StatusLineOpen) c) (Conn req (res ResponseEnded) c) Unit
notFound = Ix.do
  writeStatus statusNotFound
  contentType textHTML
  closeHeaders
  respond "Not Found"

main :: Effect Unit
main = do
  runServer defaultOptionsWithLogging {} appRouter
  where
    onRoutingError status msg
      | status == statusNotFound = fileServer "public" notFound
      | otherwise = Ix.do
        writeStatus status
        contentType textHTML
        closeHeaders
        respond (maybe "" identity msg)

    appRouter = router app home onRoutingError
