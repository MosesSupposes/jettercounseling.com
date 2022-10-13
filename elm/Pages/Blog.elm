module Pages.Blog exposing (view)

import Html exposing (..)


view : Html msg
view =
    div []
        [ h1 [] [ text "Blog" ]
        , p [] [ text "Implement me!" ]
        ]
