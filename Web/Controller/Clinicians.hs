module Web.Controller.Clinicians where

import Web.Controller.Prelude
import Web.View.Clinicians.Index
import Web.View.Clinicians.Show

instance Controller CliniciansController where
    action CliniciansAction = do
        clinicians <- query @Clinician |> fetch
        render IndexView { .. }


    action ShowClinicianAction { clinicianId, clinicianName } = do
        maybeClinician <- fetchOneOrNothing clinicianId
        case maybeClinician of
            Just clinician ->
                render ShowView { .. }
            Nothing ->
                redirectTo NotFoundAction

buildClinician clinician = clinician
    |> fill @["fullName", "email", "phoneNumber", "profilePic", "gender", "bio", "raceAndEthnicity"]
