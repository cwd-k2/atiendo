module Client.Main where

import Prelude

import Effect (Effect)

import Data.Maybe (Maybe(..))

import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.HTML.Events as HE
import Halogen.VDom.Driver as HD

data Action
  = Increment
  | Decrement

main :: Effect Unit
main =
  HA.runHalogenAff do
    body <- HA.awaitBody
    HD.runUI component unit body
  where
    component =
      H.mkComponent
        { initialState
        , render
        , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
        }
      where
        initialState = const 0

        render state =
          HH.div_
            [ HH.button [ HE.onClick $ const $ Just Decrement
                        , HP.id_ "decrement"
                        ]
                        [ HH.text "-" ]
            , HH.div    [ HP.id_ "show-state" ] [ HH.text $ show state ]
            , HH.button [ HE.onClick $ const $ Just Increment
                        , HP.id_ "increment"
                        ]
                        [ HH.text "+" ]
            ]

        handleAction = case _ of
          Increment -> H.modify_ \state -> state + 1
          Decrement -> H.modify_ \state -> state - 1
