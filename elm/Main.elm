module Main exposing (main)

import Browser
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Pages.Admin.Login as AdminLogin
import Pages.Blog as Blog
import Pages.Counselors as Counselors
import Pages.NotFound as PageNotFound


type alias Model =
    { page : Page }


type Msg
    = NoOp


type Page
    = Counselors
    | Blog
    | NotFound
    | Admin



-- TODO: Add admin routes


type Route
    = AllCounselors
    | SingleCounselor String
    | FindACounselor
    | WellnessTips


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    let
        content =
            case model.page of
                Counselors ->
                    -- TODO: Load the counselors on initial render, store it in the model, and pass it down to this view
                    Counselors.view { counselors = Dict.empty, view = Counselors.AllCounselors Dict.empty }

                Blog ->
                    Blog.view

                --Admin ->
                --   AdminLogin.view
                NotFound ->
                    PageNotFound.view

                _ ->
                    p [] []
    in
    div [ style "font-family" "BaskervilleBold" ]
        [ viewHeader model.page
        , content
        , viewFooter
        ]


isActive : { link : Route, page : Page } -> Bool
isActive { page, link } =
    case ( page, link ) of
        ( Counselors, AllCounselors ) ->
            True

        ( Counselors, SingleCounselor _ ) ->
            True

        ( Counselors, FindACounselor ) ->
            True

        ( Counselors, _ ) ->
            False

        ( Blog, WellnessTips ) ->
            True

        ( Blog, _ ) ->
            False

        ( Admin, _ ) ->
            False

        ( NotFound, _ ) ->
            False


viewHeader : Page -> Html Msg
viewHeader page =
    let
        logo =
            a [ href "/" ] [ img [ src "/static/logos/logo-01.jpg" ] [] ]

        navLink : Route -> { url : String, caption : String } -> Html Msg
        navLink route { url, caption } =
            li [ classList [ ( "isActive", isActive { link = route, page = page } ) ] ]
                [ a [ href url ] [ text caption ] ]

        links =
            nav []
                [ navLink AllCounselors { url = "/counselors", caption = "Counselors" }
                , navLink WellnessTips { url = "/wellness-tips", caption = "Wellness Tips" }

                -- TODO: Create a separate route that renders a form asking what type of services the cilent is seeking.
                -- It will will then render a list of counselors who specializes in the treatment approach they require.
                , navLink FindACounselor { url = "/counselors/find", caption = "Find a Counselor" }
                ]
    in
    header [] [ logo, links ]


viewFooter : Html msg
viewFooter =
    footer []
        [ p [] [ text "Jetter & Associates Counseling, LLC" ]
        , div
            -- TODO: Add location pin logo
            [ class "footer--address" ]
            [ p [] [ text "325 Street Road" ]
            , p [] [ text "Southampton, PA 18966" ]
            ]

        -- TODO: Add phone logo
        , p [] [ text "(215) 645 - 0338" ]
        , img [ src "/static/logo/footer-logo-01.png" ] []
        ]



-- TODO: Convert this program into a Browser.application to handle client-side-routing


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( {}
    , Cmd.none
    )
