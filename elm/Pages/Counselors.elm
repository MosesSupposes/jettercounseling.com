module Pages.Counselors exposing (Model, Msg(..), init, update, view)

import Api.Counselor exposing (Counselor)
import Api.Helper exposing (Id)
import Browser.Navigation as Nav
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Url.Builder as Path



-- The key will be represented by the counselor's ID
-- The counselors should be fetched on


type alias Model =
    { counselors : Dict String Counselor, view : View }


type View
    = AllCounselors (Dict String Counselor)
    | OneCounselor Counselor


type alias CounselorId =
    String


init : List Counselor -> ( Model, Cmd Msg )
init counselors =
    {--The URL will change depending on the view. 
    If the view is AllCounselors, then the URL should be /counselors. 
    If the view is OneCounselor, then the URL should be /counselors/{counselor's-full-name} 
-}
    let
        makeCounselorLookupTable : List Counselor -> Dict String Counselor
        makeCounselorLookupTable =
            List.foldl (\counselor counselorDict -> Dict.insert counselor.id counselor counselorDict) Dict.empty

        counselorLookupTable =
            makeCounselorLookupTable counselors
    in
    ( { counselors = counselorLookupTable, view = AllCounselors counselorLookupTable }, Cmd.none )


type Msg
    = SwitchView View


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SwitchView (AllCounselors counselors) ->
            ( { model | view = AllCounselors counselors }, Cmd.none )

        SwitchView (OneCounselor counselor) ->
            ( { model | view = OneCounselor counselor }, Cmd.none )


viewAllCounselors : Dict String Counselor -> Html Msg
viewAllCounselors counselors =
    let
        viewCounselorPreview : Counselor -> Html Msg
        viewCounselorPreview counselor =
            div []
                [ a [ href <| Path.relative [ "/counselors" ] [ Path.string "id" counselor.id ] ] []
                , p [] [ text counselor.full_name ]
                ]
    in
    Dict.foldl (\_ counselor counselorPreviews -> counselorPreviews ++ (List.singleton <| viewCounselorPreview counselor)) [] counselors
        |> div []


viewSingleCounselor : Counselor -> Html Msg
viewSingleCounselor counselor =
    div []
        [ a [ href <| Path.relative [ "/counselors" ] [ Path.string "id" counselor.id ] ] []
        , p [] [ text counselor.full_name ]
        ]


view : Model -> Html Msg
view model =
    case model.view of
        AllCounselors counselors ->
            viewAllCounselors counselors

        OneCounselor counselor ->
            viewSingleCounselor counselor
