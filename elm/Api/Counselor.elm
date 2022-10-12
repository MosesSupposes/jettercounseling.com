module Api.Counselor exposing (Counselor)

{--| This is not the full type. This is how the `counselors` table is represented on its own without any joins. 
    After unifying the related tables with some joins, the final JSON response will be much larger.
--}


type alias Counselor =
    { id : String
    , full_name : String
    , email : Maybe String
    , phone_number : Maybe String
    , profile_pic : Maybe String
    , gender : Maybe String
    , bio : Maybe String
    , race_and_ethnicity : Maybe String
    }
