module Atiendo.Server.Route.Web.Home
  ( homeHandler
  ) where

import Prelude

import Node.Express.Handler (Handler)
import Node.Express.Response (send)

import Text.Smolder.HTML (head, html, script, link, title)
import Text.Smolder.HTML.Attributes (href, lang, rel, src)
import Text.Smolder.Markup (Markup, empty, text, (!))
import Text.Smolder.Renderer.String (render)

home :: Markup Unit
home = html ! lang "en" $ do
  head $ do
    script ! src "/scripts/app.js" $ empty
    link ! href "/styles/app.css" ! rel "stylesheet"
    title $ text "Atiendo | Home"

homeHandler :: Handler
homeHandler = send <<< render $ home

