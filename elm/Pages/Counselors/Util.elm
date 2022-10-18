module Pages.Counselors.Util exposing (..)


toUrl : String -> String
toUrl counselorName =
    String.replace " " "-" counselorName


fromUrl : String -> String
fromUrl counselorName =
    String.replace "-" " " counselorName
