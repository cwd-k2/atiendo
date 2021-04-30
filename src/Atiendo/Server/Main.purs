module Atiendo.Server.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

import Node.Express.App (App, get, listenHttp, use)
import Node.Express.Middleware.Static (static)

import Atiendo.Server.Route.Web.Home (homeHandler)
import Atiendo.Server.Route.API.Ping (pingHandler)

app :: App
app = do
  get "/"         $ homeHandler
  get "/api/ping" $ pingHandler
  use             $ static "public"

port :: Int
port = 3000

main :: Effect Unit
main = do
  void $ listenHttp app port \_ ->
    log $ "listening http://localhost:" <> show port
