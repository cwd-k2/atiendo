module Server.Web.Home
  ( Home
  , homeResource
  ) where

import Prelude

import Control.Monad.Except (ExceptT)

import Text.Smolder.HTML (head, html, script, link, title)
import Text.Smolder.HTML.Attributes (lang, src, href, rel)
import Text.Smolder.Markup (empty, text, (!))

import Type.Trout.ContentType.HTML (class EncodeHTML)

import Hyper.Trout.Router (RoutingError)

data Home = Home

homeResource :: forall m. Monad m => { "GET" :: ExceptT RoutingError m Home }
homeResource = { "GET": pure Home }

instance encodeHTMLHome :: EncodeHTML Home where
  encodeHTML Home =
    html ! lang "en" $ do
      head $ do
        script ! src "/scripts/app.js" $ empty
        link ! href "/styles/app.css" ! rel "stylesheet"
        title $ text "Atiendo | Home"
