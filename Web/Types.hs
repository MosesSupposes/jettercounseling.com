module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data CliniciansController
    = CliniciansAction
    | ShowClinicianAction 
        { clinicianId :: !(Maybe (Id Clinician))
        , clinicianName :: !(Maybe Text) 
        }
    deriving (Eq, Show, Data)

