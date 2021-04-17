{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "atiendo"
, dependencies =
  [ "console"
  , "effect"
  , "halogen"
  , "hyper"
  , "hypertrout"
  , "prelude"
  , "psci-support"
  , "smolder"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
