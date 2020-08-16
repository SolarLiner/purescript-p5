{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "p5"
, dependencies =
  [ "colors"
  , "console"
  , "effect"
  , "math"
  , "prelude"
  , "psci-support"
  , "sized-vectors"
  , "transformers"
  , "typelevel"
  , "web-html"
  ]
, repo = "https://github.com/solarliner/purescript-p5.git"
, version = "master"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
