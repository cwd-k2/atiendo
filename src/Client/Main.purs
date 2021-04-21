module Client.Main where

import Prelude

import Effect (Effect)
import Effect.Aff.Class (class MonadAff)

import Data.Maybe (Maybe(..))
import Data.Either (Either(..))

import Affjax (get, printError)
import Affjax.ResponseFormat (json)

import Data.Argonaut.Core (stringify)

import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.HTML.Events as HE
import Halogen.VDom.Driver (runUI)

data Action
  = Increment
  | Decrement

app :: forall q m. MonadAff m => H.Component HH.HTML q Unit Void m
app = H.mkComponent
        { initialState: const "..."
        , render
        , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
        }
  where
    render state =
      HH.div_
        [ HH.button [ HE.onClick $ const $ Just Decrement , HP.id_ "decrement" ]
                    [ HH.text "decrement" ]
        , HH.button [ HE.onClick $ const $ Just Increment , HP.id_ "increment" ]
                    [ HH.text "increment" ]
        , HH.div    [ HP.id_ "show-state" ] [ HH.text state ]
        ]

    handleAction = case _ of
      Increment -> do
        result <- H.liftAff $ get json "/api/ping"
        case result of
          Left err  -> H.modify_ $ const $ printError err
          Right res -> H.modify_ $ const $ stringify res.body

      Decrement -> H.modify_ $ const "..."



main :: Effect Unit
main =
  HA.runHalogenAff do
    body <- HA.awaitBody
    runUI app unit body
