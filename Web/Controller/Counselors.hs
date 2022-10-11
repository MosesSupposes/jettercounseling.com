module Web.Controller.Counselors where

import Web.Controller.Prelude
import Web.View.Counselors.Index
import Web.View.Counselors.New
import Web.View.Counselors.Edit
import Web.View.Counselors.Show

instance Controller CounselorsController where
    -- TODO: Remove
    action CounselorsAction = do
        counselors <- query @Counselor |> fetch
        render IndexView { .. }

    -- TODO: Remove
    action NewCounselorAction = do
        let counselor = newRecord
        render NewView { .. }

    -- TODO: Remove
    action ShowCounselorAction { counselorId } = do
        counselor <- fetch counselorId
        render ShowView { .. }

    -- TODO: Remove
    action EditCounselorAction { counselorId } = do
        counselor <- fetch counselorId
        render EditView { .. }

    action UpdateCounselorAction { counselorId } = do
        counselor <- fetch counselorId
        counselor
            |> buildCounselor
            |> ifValid \case
                Left counselor -> render EditView { .. }
                Right counselor -> do
                    counselor <- counselor |> updateRecord
                    setSuccessMessage "Counselor updated"
                    redirectTo EditCounselorAction { .. }

    action CreateCounselorAction = do
        let counselor = newRecord @Counselor
        counselor
            |> buildCounselor
            |> ifValid \case
                Left counselor -> render NewView { .. } 
                Right counselor -> do
                    counselor <- counselor |> createRecord
                    setSuccessMessage "Counselor created"
                    redirectTo CounselorsAction

    action DeleteCounselorAction { counselorId } = do
        counselor <- fetch counselorId
        deleteRecord counselor
        setSuccessMessage "Counselor deleted"
        redirectTo CounselorsAction

buildCounselor counselor = counselor
    |> fill @["fullName", "email", "phoneNumber", "profilePic", "gender", "bio", "raceAndEthnicity"]
    |> emptyValueToNothing #email
    |> emptyValueToNothing #phoneNumber
    |> emptyValueToNothing #profilePic
    |> emptyValueToNothing #gender
    |> emptyValueToNothing #bio
    |> emptyValueToNothing #raceAndEthnicity
