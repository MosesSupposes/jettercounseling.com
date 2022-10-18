module Pages.Counselors.SingleCounselor exposing (Model, Msg, init, update, view)

import Api.Counselor exposing (Counselor)
import Api.Helper exposing (Id)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)



-- MODEL


type alias Model =
    Maybe Counselor


init : String -> ( Model, Cmd msg )
init counselorName =
    -- TODO: Fetch counselor by name then load it into state
    ( Nothing, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html msg
view model =
    case model of
        Just counselor ->
            viewCounselor counselor

        -- TODO: Render a nicer loading indicator
        Nothing ->
            text "Loading..."


viewCounselor : Counselor -> Html msg
viewCounselor counselor =
    div []
        [ img [ src <| Maybe.withDefault "" counselor.profile_pic ] []
        , p [] [ text counselor.full_name ]
        , p [] [ text <| Maybe.withDefault "" counselor.bio ]
        ]
