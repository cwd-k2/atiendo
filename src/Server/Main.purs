module Server.Main where

import Prelude

import Effect (Effect)

import Hyper.Node.Server (defaultOptionsWithLogging, runServer)

import Server.App (appRouter)

main :: Effect Unit
main = do
  runServer defaultOptionsWithLogging {} appRouter
