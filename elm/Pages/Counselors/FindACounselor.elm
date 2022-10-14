module Pages.Counselors.FindACounselor exposing (Model, Msg, init, update, view)

import Html exposing (..)



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Cmd msg )
init () =
    ( {}, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( {}, Cmd.none )



-- VIEW


view : Model -> Html msg
view model =
    div []
        [ h1 [] [ text "Find a counselor" ]
        , p [] [ text "Implement me!" ]
        ]
