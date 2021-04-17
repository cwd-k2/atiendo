module Server.Main where

import Prelude

import Effect (Effect)
-- import Effect.Console

import Control.Monad.Indexed.Qualified as Ix

import Data.Maybe (maybe)
import Data.MediaType.Common (textHTML)

import Hyper.Node.Server (defaultOptionsWithLogging, runServer)
import Hyper.Node.FileServer (fileServer)
import Hyper.Response (closeHeaders, contentType, respond, writeStatus)
import Hyper.Status (statusNotFound)
import Hyper.Trout.Router (router)

import Text.Smolder.HTML (head, html, script, link)
import Text.Smolder.HTML.Attributes (lang, src, href, rel)
import Text.Smolder.Markup (empty, (!))

import Type.Proxy (Proxy(..))
import Type.Trout (Resource)
import Type.Trout.Method (Get)
import Type.Trout.ContentType.HTML (class EncodeHTML, HTML)

data Home = Home

type App = Resource (Get Home HTML)

home :: forall m. Applicative m => { "GET" :: m Home }
home = { "GET": pure Home }

instance encodeHTMLHome :: EncodeHTML Home where
  encodeHTML Home =
    html ! lang "en" $ do
      head $ do
        script ! src "/scripts/app.js" $ empty
        link ! href "/styles/app.css" ! rel "stylesheet"

app :: Proxy App
app = Proxy

main :: Effect Unit
main = do
  runServer defaultOptionsWithLogging {} appRouter
  where
    notFound = Ix.do
      writeStatus statusNotFound
      contentType textHTML
      closeHeaders
      respond "Not Found"

    onRoutingError status msg
      | status == statusNotFound = fileServer "public" notFound
      | otherwise = Ix.do
        writeStatus status
        contentType textHTML
        closeHeaders
        respond (maybe "" identity msg)

    appRouter = router app home onRoutingError
