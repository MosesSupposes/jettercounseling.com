module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Lazy exposing (lazy)
import Pages.Admin.Dashboard
import Pages.Blog
import Pages.Counselors.AllCounselors
import Pages.Counselors.FindACounselor
import Pages.Counselors.SingleCounselor
import Pages.Counselors.Util as CounselorUtils
import Pages.LandingPage
import Pages.NotFound
import Url
import Url.Parser as Parser exposing ((</>), Parser, s, string)


type alias Model =
    { page : Page, key : Nav.Key }


type Page
    = LandingPage Pages.LandingPage.Model
    | AllCounselorsPage Pages.Counselors.AllCounselors.Model
    | SingleCounselorPage Pages.Counselors.SingleCounselor.Model
    | FindACounselorPage Pages.Counselors.FindACounselor.Model
    | BlogPage Pages.Blog.Model
    | AdminDashboardPage Pages.Admin.Dashboard.Model
    | NotFoundPage


type Route
    = Home
    | AllCounselors
    | SingleCounselor String
    | FindACounselor
    | Blog
    | AdminDashboard


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotLandingPageMsg Pages.LandingPage.Msg
    | GotAllCounselorsPageMsg Pages.Counselors.AllCounselors.Msg
    | GotSingleCounselorPageMsg Pages.Counselors.SingleCounselor.Msg
    | GotFindACounselorPageMsg Pages.Counselors.FindACounselor.Msg
    | GotBlogPageMsg Pages.Blog.Msg
    | GotAdminDashboardPageMsg Pages.Admin.Dashboard.Msg


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

        GotLandingPageMsg landingPageMsg ->
            case model.page of
                LandingPage landingPageModel ->
                    toLandingPage model (Pages.LandingPage.update landingPageMsg landingPageModel)

                _ ->
                    ( model, Cmd.none )

        GotAllCounselorsPageMsg allCounselorsPageMsg ->
            case model.page of
                AllCounselorsPage allCounselorsPageModel ->
                    toAllCounselorsPage model (Pages.Counselors.AllCounselors.update allCounselorsPageMsg allCounselorsPageModel)

                _ ->
                    ( model, Cmd.none )

        GotSingleCounselorPageMsg singleCounselorPageMsg ->
            case model.page of
                SingleCounselorPage singleCounselorPageModel ->
                    toSingleCounselorPage model (Pages.Counselors.SingleCounselor.update singleCounselorPageMsg singleCounselorPageModel)

                _ ->
                    ( model, Cmd.none )

        GotFindACounselorPageMsg findACounselorPageMsg ->
            case model.page of
                FindACounselorPage findACounselorPageModel ->
                    toFindACounselorPage model (Pages.Counselors.FindACounselor.update findACounselorPageMsg findACounselorPageModel)

                _ ->
                    ( model, Cmd.none )

        GotBlogPageMsg blogPageMsg ->
            case model.page of
                BlogPage blogPageModel ->
                    toBlogPage model (Pages.Blog.update blogPageMsg blogPageModel)

                _ ->
                    ( model, Cmd.none )

        GotAdminDashboardPageMsg adminDashboardPageMsg ->
            case model.page of
                AdminDashboardPage adminDashboardPageModel ->
                    toAdminDashboardPage model (Pages.Admin.Dashboard.update adminDashboardPageMsg adminDashboardPageModel)

                _ ->
                    ( model, Cmd.none )


updateUrl : Url.Url -> Model -> ( Model, Cmd Msg )
updateUrl url model =
    case Parser.parse parser url of
        Just Home ->
            Pages.LandingPage.init ()
                |> toLandingPage model

        Just AllCounselors ->
            Pages.Counselors.AllCounselors.init ()
                |> toAllCounselorsPage model

        Just (SingleCounselor counselorName) ->
            Pages.Counselors.SingleCounselor.init counselorName
                |> toSingleCounselorPage model

        Just FindACounselor ->
            Pages.Counselors.FindACounselor.init ()
                |> toFindACounselorPage model

        Just Blog ->
            Pages.Blog.init ()
                |> toBlogPage model

        Just AdminDashboard ->
            Pages.Admin.Dashboard.init ()
                |> toAdminDashboardPage model

        Nothing ->
            ( { model | page = NotFoundPage }, Cmd.none )


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map AllCounselors (Parser.s "counselors")

        -- TODO: Remove this page
        , Parser.map FindACounselor (Parser.s "counselors" </> Parser.s "find")
        , Parser.map SingleCounselor (Parser.s "counselors" </> string)
        , Parser.map Blog (Parser.s "blog")
        , Parser.map AdminDashboard (Parser.s "admin")
        ]


toLandingPage : Model -> ( Pages.LandingPage.Model, Cmd Pages.LandingPage.Msg ) -> ( Model, Cmd Msg )
toLandingPage model ( subModel, subCmd ) =
    ( { model | page = LandingPage subModel }, Cmd.map GotLandingPageMsg subCmd )


toAllCounselorsPage : Model -> ( Pages.Counselors.AllCounselors.Model, Cmd Pages.Counselors.AllCounselors.Msg ) -> ( Model, Cmd Msg )
toAllCounselorsPage model ( subModel, subCmd ) =
    ( { model | page = AllCounselorsPage subModel }, Cmd.map GotAllCounselorsPageMsg subCmd )


toSingleCounselorPage : Model -> ( Pages.Counselors.SingleCounselor.Model, Cmd Pages.Counselors.SingleCounselor.Msg ) -> ( Model, Cmd Msg )
toSingleCounselorPage model ( subModel, subCmd ) =
    ( { model | page = SingleCounselorPage subModel }, Cmd.map GotSingleCounselorPageMsg subCmd )


toFindACounselorPage : Model -> ( Pages.Counselors.FindACounselor.Model, Cmd Pages.Counselors.FindACounselor.Msg ) -> ( Model, Cmd Msg )
toFindACounselorPage model ( subModel, subCmd ) =
    ( { model | page = FindACounselorPage subModel }, Cmd.map GotFindACounselorPageMsg subCmd )


toBlogPage : Model -> ( Pages.Blog.Model, Cmd Pages.Blog.Msg ) -> ( Model, Cmd Msg )
toBlogPage model ( subModel, subCmd ) =
    ( { model | page = BlogPage subModel }, Cmd.map GotBlogPageMsg subCmd )


toAdminDashboardPage : Model -> ( Pages.Admin.Dashboard.Model, Cmd Pages.Admin.Dashboard.Msg ) -> ( Model, Cmd Msg )
toAdminDashboardPage model ( subModel, subCmd ) =
    ( { model | page = AdminDashboardPage subModel }, Cmd.map GotAdminDashboardPageMsg subCmd )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        content : Html Msg
        content =
            case model.page of
                LandingPage landingPageModel ->
                    Pages.LandingPage.view landingPageModel
                        |> Html.map GotLandingPageMsg

                AllCounselorsPage allCounselors ->
                    Pages.Counselors.AllCounselors.view allCounselors
                        |> Html.map GotAllCounselorsPageMsg

                SingleCounselorPage counselor ->
                    Pages.Counselors.SingleCounselor.view counselor
                        |> Html.map GotSingleCounselorPageMsg

                FindACounselorPage findACounselorModel ->
                    Pages.Counselors.FindACounselor.view findACounselorModel
                        |> Html.map GotFindACounselorPageMsg

                BlogPage blogModel ->
                    Pages.Blog.view blogModel
                        |> Html.map GotBlogPageMsg

                AdminDashboardPage adminDashboardModel ->
                    Pages.Admin.Dashboard.view adminDashboardModel
                        |> Html.map GotAdminDashboardPageMsg

                NotFoundPage ->
                    Pages.NotFound.view

        deriveTitleFromCurrentPage : Page -> String
        deriveTitleFromCurrentPage page =
            let
                companyName =
                    " | Jetter Counseling & Associates"
            in
            case page of
                LandingPage _ ->
                    "Home" ++ companyName

                AllCounselorsPage _ ->
                    "Counselors" ++ companyName

                SingleCounselorPage (Just counselor) ->
                    CounselorUtils.fromUrl counselor.full_name ++ companyName

                SingleCounselorPage Nothing ->
                    CounselorUtils.fromUrl "Loading... " ++ companyName

                FindACounselorPage _ ->
                    "Find a Counselor" ++ companyName

                BlogPage _ ->
                    "Guidance" ++ companyName

                AdminDashboardPage _ ->
                    "Control Panel" ++ companyName

                NotFoundPage ->
                    "Page Not Found" ++ companyName
    in
    { title = deriveTitleFromCurrentPage model.page
    , body =
        [ div [ style "font-family" "Baskerville" ]
            [ viewHeader model.page
            , content
            , viewFooter
            ]
        ]
    }


isActive : { link : Route, page : Page } -> Bool
isActive { link, page } =
    case ( link, page ) of
        ( AllCounselors, AllCounselorsPage _ ) ->
            True

        ( AllCounselors, _ ) ->
            False

        ( FindACounselor, FindACounselorPage _ ) ->
            True

        ( FindACounselor, _ ) ->
            False

        ( Blog, BlogPage _ ) ->
            True

        ( Blog, _ ) ->
            False

        -- The remaining links/routes aren't present in the header
        ( Home, _ ) ->
            False

        ( AdminDashboard, _ ) ->
            False

        ( SingleCounselor _, _ ) ->
            False


viewHeader : Page -> Html Msg
viewHeader page =
    let
        logo =
            div [ class "header__logo-container" ]
                [ a [ href "/" ]
                    [ img
                        [ class "header__logo-img"
                        , src "/logos/logo-01.jpg"
                        ]
                        []
                    ]
                ]

        navLink : Route -> { url : String, caption : String } -> Html Msg
        navLink route { url, caption } =
            li [ classList [ ( "isActive", isActive { link = route, page = page } ) ] ]
                [ a [ href url ] [ text caption ] ]

        links =
            nav [ class "header__nav" ]
                [ navLink AllCounselors { url = "/counselors", caption = "Our Counselors" }
                , navLink Home { url = "/#services", caption = "Services" }
                , navLink Home { url = "/#about", caption = "About" }
                , navLink Blog { url = "/blog", caption = "Blog" }
                ]
    in
    header [ class "header__container" ] [ logo, links ]


viewFooter : Html msg
viewFooter =
    footer [ class "footer__container" ]
        [ div [ class "footer__logo-container" ]
            [ img
                [ class "footer__logo-img"

                -- , src "logos/footer-logo-01.png"
                , src "logos/logo-white.png"
                ]
                []
            ]
        , div [ class "footer__information" ]
            [ div [ class "footer__contact" ]
                [ h3 [] [ text "Contact Us" ]
                , p [] [ text "(215) 337-2203, Ext. 1" ]
                ]
            , div [ class "footer__address" ]
                [ h3 [] [ text "Location" ]
                , p [] [ text "325 Street Rd" ]
                , p [] [ text "Southampton, PA 18966" ]
                , iframe
                    [ src "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3048.349572838604!2d-75.05565156783776!3d40.17903321348353!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c6add195cbed87%3A0x671f8cadfe127f9a!2s325%20Street%20Rd%2C%20Southampton%2C%20PA%2018966!5e0!3m2!1sen!2sus!4v1666594728131!5m2!1sen!2sus"
                    , width 175
                    , height 120
                    , style "border" "0"
                    , attribute "allowfullscreen" ""
                    , attribute "loading" "lazy"
                    ]
                    []
                ]
            ]
        , p [ class "footer__copyright" ]
            [ text "Copyright © Jetter & Associates Counseling, LLC" ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        , subscriptions = subscriptions
        , view = view
        }



-- TODO: We will receive all data this app needs as flags on initial load.
-- When calling the updateURl function, we should pass portions of this data to the init function on each page.


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init () url key =
    updateUrl url { page = NotFoundPage, key = key }
