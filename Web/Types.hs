module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data CliniciansController
    = CliniciansAction
    | NewClinicianAction
    | ShowClinicianAction { clinicianId :: !(Id Clinician) }
    | CreateClinicianAction
    | EditClinicianAction { clinicianId :: !(Id Clinician) }
    | UpdateClinicianAction { clinicianId :: !(Id Clinician) }
    | DeleteClinicianAction { clinicianId :: !(Id Clinician) }
    deriving (Eq, Show, Data)
