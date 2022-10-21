module Pages.Blog exposing (Model, Msg, init, update, view)

import Html exposing (..)



-- MODEL


type alias Model =
    ()


init : () -> ( Model, Cmd Msg )
init () =
    ( (), Cmd.none )



-- UPDATE


type alias Msg =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( (), Cmd.none )



-- VIEW


view : Model -> Html msg
view _ =
    div []
        [ h1 [] [ text "Blog" ]
        , p [] [ text "Implement me!" ]
        ]
