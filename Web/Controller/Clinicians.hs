module Web.Controller.Clinicians where

import Web.Controller.Prelude
import Web.View.Clinicians.Index
import Web.View.Clinicians.Show
import Web.View.Static.NotFound (NotFoundView(..))
import Application.Helper.Controller (fromSlugToFullWord)

instance Controller CliniciansController where
    action CliniciansAction = do
        clinicians <- query @Clinician |> fetch
        render IndexView { .. }


    -- TODO: Fix bug where NotFoundView is being rendered for each path, even when provided a valid ID.
    action ShowClinicianAction { clinicianId, clinicianName } =
        case (clinicianId, clinicianName) of 
            (Nothing , Nothing) -> 
                render NotFoundView

            (Just clinicianId', _) -> do
                maybeClinician <- query @Clinician |> findMaybeBy #id clinicianId' 
                renderClinicianIfFound maybeClinician


            (Nothing, Just clinicianName') -> do
                maybeClinician <- query @Clinician |> findMaybeBy #fullName (fromSlugToFullWord clinicianName') 
                renderClinicianIfFound maybeClinician
        where 
            renderClinicianIfFound maybeClinician = case maybeClinician of 
                 (Just clinician) -> 
                    render ShowView {..}
                 (Nothing) -> 
                    render NotFoundView
                
                 
            

buildClinician clinician = clinician
    |> fill @["fullName", "email", "phoneNumber", "profilePic", "gender", "bio", "raceAndEthnicity"]
