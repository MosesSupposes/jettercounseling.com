module Pages.NotFound exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href)


view : Html msg
view =
    div []
        [ p [] [ text "Sorry, the information you were looking for was either relocated or doesn't exist." ]
        , button []
            [ a [ href "/" ] [ text "Return to website" ]
            ]
        ]
