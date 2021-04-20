module Server.Web
  ( Web
  , webResources
  ) where

import Type.Trout (type (:=), Resource)
import Type.Trout.Method (Get)
import Type.Trout.ContentType.HTML (HTML)

import Server.Web.Home (Home, homeResource)

type Web = "home" := Resource (Get Home HTML)

webResources =
  { "home": homeResource
  }
