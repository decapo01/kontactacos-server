module Main where

import Prelude

import Contact (Contact)
import Data.Foldable (for_)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Console (log)
import HTTPure as HTTPure
import Simple.JSON as SimpleJSON

contacts :: Array Contact
contacts =
  [ { id: "1"
    , name: "vilham"
    , email: "vilham@demo.com"
    , phone: "12345677"
    }
  , { id: "2"
    , name: "rick"
    , email: "rick@demo.com"
    , phone: "123456773"
    }
  , { id: "3"
    , name: "abed"
    , email: "abed@demo.com"
    , phone: "321456773"
    }
  ]


jsonHeader = 
  HTTPure.headers 
    [ Tuple "Content-Type" "application/json"
    , Tuple "Access-Control-Allow-Origin" "*"
    ]

-- okJson :: String -> HTTPure.ResponseM
-- okJson body = pure $ { status: 200, headers: HTTPure.headers [], body: body}

router :: HTTPure.Request -> HTTPure.ResponseM
router { path: ["contacts"] } = HTTPure.ok' jsonHeader (SimpleJSON.writeJSON contacts)
router _                      = HTTPure.notFound

main :: HTTPure.ServerM
main = do
  HTTPure.serve 9000 router do
    log "🍝"
    for_ contacts $ \c -> log c.name