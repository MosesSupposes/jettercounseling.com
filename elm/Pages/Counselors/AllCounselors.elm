module Pages.Counselors.AllCounselors exposing (Model, Msg, init, update, view)

import Api.Counselor exposing (Counselor)
import Api.Helper exposing (Id)
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)



-- MODEL


type alias Model =
    List Counselor



-- TODO: Fetch counselors from DB on initial load


init : () -> ( Model, Cmd msg )
init () =
    ( [], Cmd.none )



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
    viewAllCounselors model


viewAllCounselors : List Counselor -> Html Msg
viewAllCounselors =
    let
        viewCounselorPreview : Counselor -> Html Msg
        viewCounselorPreview counselor =
            div []
                [ a [ href <| "/counselors/" ++ String.replace " " "-" counselor.full_name ]
                    [ div []
                        -- TODO: Render a default image when there's no profile pic found
                        [ img [ src <| Maybe.withDefault "" counselor.profile_pic ] []
                        , p [] [ text counselor.full_name ]

                        -- TODO: Render each counselor's specialties
                        ]
                    ]
                ]
    in
    List.map viewCounselorPreview >> div []
