module Server.App.Home
  ( home
  , Home
  ) where

import Prelude

import Text.Smolder.HTML (head, html, script, link, title)
import Text.Smolder.HTML.Attributes (lang, src, href, rel)
import Text.Smolder.Markup (empty, text, (!))

import Type.Trout.ContentType.HTML (class EncodeHTML)

data Home = Home

home :: forall m. Applicative m => { "GET" :: m Home }
home = { "GET": pure Home }

instance encodeHTMLHome :: EncodeHTML Home where
  encodeHTML Home =
    html ! lang "en" $ do
      head $ do
        script ! src "/scripts/app.js" $ empty
        link ! href "/styles/app.css" ! rel "stylesheet"
        title $ text "Atiend | Home"
