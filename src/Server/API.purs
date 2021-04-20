module Server.API
  ( API
  , apiResources
  ) where

import Type.Trout (type (:=), type (:/), Resource)
import Type.Trout.Method (Get)
import Type.Trout.ContentType.JSON (JSON)

import Server.API.Ping (Ping, pingResource)

type API = "ping" := "ping" :/ Resource (Get Ping JSON)

apiResources =
  { "ping": pingResource
  }

