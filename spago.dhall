{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "atiendo"
, dependencies =
  [ "affjax"
  , "console"
  , "effect"
  , "express"
  , "halogen"
  , "prelude"
  , "psci-support"
  , "smolder"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
