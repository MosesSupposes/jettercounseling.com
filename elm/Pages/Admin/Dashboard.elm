module Pages.Admin.Dashboard exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Pages.Admin.Util exposing (Credentials, validateCredentials)



-- MODEL


type alias Model =
    { isAuthorized : Bool }


init : () -> ( Model, Cmd Msg )
init creds =
    ( { isAuthorized = False }, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    if model.isAuthorized then
        div [] [ text "Admin Dashboard (implement me!)" ]

    else
        -- Show the login page
        div [] [ text "Admin Login (implement me!)" ]
