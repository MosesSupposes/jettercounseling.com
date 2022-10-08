module Web.Controller.Clinicians where

import Web.Controller.Prelude
import Web.View.Clinicians.Index
import Web.View.Clinicians.New
import Web.View.Clinicians.Edit
import Web.View.Clinicians.Show

instance Controller CliniciansController where
    action CliniciansAction = do
        clinicians <- query @Clinician |> fetch
        render IndexView { .. }

    action NewClinicianAction = do
        let clinician = newRecord
        render NewView { .. }

    action ShowClinicianAction { clinicianId } = do
        clinician <- fetch clinicianId
        render ShowView { .. }

    action EditClinicianAction { clinicianId } = do
        clinician <- fetch clinicianId
        render EditView { .. }

    action UpdateClinicianAction { clinicianId } = do
        clinician <- fetch clinicianId
        clinician
            |> buildClinician
            |> ifValid \case
                Left clinician -> render EditView { .. }
                Right clinician -> do
                    clinician <- clinician |> updateRecord
                    setSuccessMessage "Clinician updated"
                    redirectTo EditClinicianAction { .. }

    action CreateClinicianAction = do
        let clinician = newRecord @Clinician
        clinician
            |> buildClinician
            |> ifValid \case
                Left clinician -> render NewView { .. } 
                Right clinician -> do
                    clinician <- clinician |> createRecord
                    setSuccessMessage "Clinician created"
                    redirectTo CliniciansAction

    action DeleteClinicianAction { clinicianId } = do
        clinician <- fetch clinicianId
        deleteRecord clinician
        setSuccessMessage "Clinician deleted"
        redirectTo CliniciansAction

buildClinician clinician = clinician
    |> fill @["fullName", "email", "phoneNumber", "profilePic", "gender", "bio", "raceAndEthnicity"]
