module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Pages.Admin.Dashboard
import Pages.Admin.Login
import Pages.Counselors.AllCounselors
import Pages.Counselors.FindACounselor
import Pages.Counselors.SingleCounselor
import Pages.GuidanceZone
import Pages.LandingPage
import Pages.NotFound
import Url
import Url.Parser as Parser exposing ((</>), Parser, s, string)


type alias Model =
    { page : Page, key : Nav.Key }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotLandingPageMsg Pages.LandingPage.Msg
    | GotAllCounselorsPageMsg Pages.Counselors.AllCounselors.Msg
    | GotSingleCounselorPageMsg Pages.Counselors.SingleCounselor.Msg
    | GotFindACounselorPageMsg Pages.Counselors.FindACounselor.Msg
    | GotGuidanceZonePageMsg Pages.GuidanceZone.Msg
    | GotAdminLoginPageMsg Pages.Admin.Login.Msg
    | GotAdminDashboardPageMsg Pages.Admin.Dashboard.Msg


type Page
    = LandingPage Pages.LandingPage.Model
    | AllCounselorsPage Pages.Counselors.AllCounselors.Model
    | SingleCounselorPage Pages.Counselors.SingleCounselor.Model
    | FindACounselorPage Pages.Counselors.FindACounselor.Model
    | GuidanceZonePage Pages.GuidanceZone.Model
    | AdminLoginPage Pages.Admin.Login.Model
    | AdminDashboardPage Pages.Admin.Dashboard.Model
    | NotFoundPage


type Route
    = Home
    | AllCounselors
    | SingleCounselor String
    | FindACounselor
    | GuidanceZone
    | AdminLogin
    | AdminDashboard


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            updateUrl url model



{--
    Make sure to update the `updateUrl` function after making an addition/removal to the body of this function. 
    That function [updateUrl] isn't exhaustively checked by the compiler. 
--}
-- This is an abstraction of the `toFolders`, and `toGallery` functions in Elm in Action
{--
integrate : PageIntegration -> Model -> ( model, Cmd msg ) -> ( Model, Cmd Msg )
integrate integration model ( subModel, subCmd ) =
    case integration of
        LandingPageIntegration ->
            ( { model | page = LandingPage subModel }, Cmd.map GotLandingPageMsg subCmd )

        AllCounselorsPageIntegration ->
            ( { model | page = AllCounselorsPage subModel }, Cmd.map GotAllCounselorsPageMsg subCmd )

        SingleCounselor _ ->
            ( { model | page = SingleCounselorPage subModel }, Cmd.map GotSingleCounselorPageMsg subCmd )

        FindACounselor ->
            ( { model | page = FindACounselorPage subModel }, Cmd.map GotFindACounselorPageMsg subCmd )

        GuidanceZone ->
            ( { model | page = GuidanceZonePage subModel }, Cmd.map GotGuidanceZonePageMsg subCmd )

        AdminLogin ->
            ( { model | page = AdminLoginPage subModel }, Cmd.map GotAdminLoginPageMsg subCmd )

        AdminDashboard ->
            ( { model | page = AdminDashboardPage subModel }, Cmd.map GotAdminDashboardPageMsg subCmd )

            --}


updateUrl : Url.Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse parser url of
        Just Home ->
            Pages.LandingPage.init ()
                |> integrate model Home

        Just AllCounselors ->
            Pages.Counselors.AllCounselors.init
                |> integrate model AllCounselors

        Just (SingleCounselor counselor) ->
            Pages.Counselors.SingleCounselor.init
                |> integrate model SingleCounselor

        Nothing ->
            ( { model | page = NotFoundPage }, Cmd.none )


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map AllCounselors (Parser.s "counselors")
        , Parser.map FindACounselor (Parser.s "counselors" </> Parser.s "find")
        , Parser.map SingleCounselor (Parser.s "counselors" </> string)
        , Parser.map GuidanceZone (Parser.s "guidance")
        , Parser.map AdminLogin (Parser.s "veil")
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    let
        content =
            case model.page of
                LandingPage landingPageModel ->
                    Pages.LandingPage.view landingPageModel

                AllCounselorsPage allCounselors ->
                    Pages.Counselors.AllCounselors.view allCounselors

                SingleCounselorPage counselor ->
                    Pages.Counselors.SingleCounselor.view counselor

                GuidanceZonePage guidanceZoneModel ->
                    Pages.GuidanceZone.view guidanceZoneModel

                AdminLoginPage credentials ->
                    Pages.Admin.Login.view credentials

                AdminDashboardPage adminDashboardModel ->
                    Pages.Admin.Dashboard.view adminDashboardModel

                NotFoundPage ->
                    Pages.NotFound.view
    in
    div [ style "font-family" "BaskervilleBold" ]
        [ viewHeader model.page
        , content
        , viewFooter
        ]


isActive : { link : Route, page : Page } -> Bool
isActive { link, page } =
    case ( link, page ) of
        ( AllCounselors, AllCounselorsPage _ ) ->
            True

        ( SingleCounselor _, SingleCounselorPage _ ) ->
            True

        ( FindACounselor, FindACounselorPage _ ) ->
            True

        ( GuidanceZone, GuidanceZonePage _ ) ->
            True

        -- The remaining pages aren't present on the header
        ( _, LandingPage _ ) ->
            False

        ( _, AdminLoginPage _ ) ->
            False

        ( _, AdminDashboardPage _ ) ->
            False

        ( _, NotFoundPage ) ->
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
                [ navLink AllCounselors { url = "/counselors", caption = "Our Counselors" }
                , navLink FindACounselor { url = "/counselors/find", caption = "Tell us Your Needs" }
                , navLink GuidanceZone { url = "/guidance", caption = "Guidance Zone" }

                -- TODO: Create a separate route that renders a form asking what type of services the cilent is seeking.
                -- It will will then render a list of counselors who specializes in the treatment approach they require.
                ]
    in
    header [] [ logo, links ]


viewFooter : Html msg
viewFooter =
    footer []
        [ p [] [ text "Jetter & Associates Counseling, LLC" ]
        , div
            -- TODO: Add location pin logo
            [ class "footer__address" ]
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
