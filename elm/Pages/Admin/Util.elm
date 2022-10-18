module Pages.Admin.Util exposing (..)


type alias Credentials =
    { username : String, password : String }



-- TODO: DO NOT validate unhashed password here. This validation should done on the backend.


validateCredentials : Credentials -> Bool
validateCredentials credentials =
    False
