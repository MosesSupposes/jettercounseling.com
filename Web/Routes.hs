module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute StaticController

instance HasPath CliniciansController where
    pathTo ShowClinicianAction { clinicianId = Just clinicianId, clinicianName = Just clinicianName } = "/clinicians/" <> tshow clinicianName
    pathTo CliniciansAction = "/clinicians"
    pathTo ShowClinicianAction { clinicianId = Nothing, clinicianName = Just clinicianName } = "/clinicians/" <> tshow clinicianName
    pathTo ShowClinicianAction { clinicianId = Just clinicianId, clinicianName = Nothing } = "/clinicians/" <> tshow clinicianId
    pathTo ShowClinicianAction { clinicianId = Nothing, clinicianName = Nothing } = "/this_route_should_never_be_reached"

instance CanRoute CliniciansController where
    parseRoute' = do 
        let allClinicians = do 
            { string "/clinicians"
            ; optional "/"
            ; endOfInput
            ; pure CliniciansAction 
            }

        let specificClinicianByName = do
            { string "/clinicians/"
            ; clinicianName <- parseText
            ; optional "/"
            ; endOfInput
            ; pure ShowClinicianAction { clinicianId = Nothing, clinicianName = Just clinicianName } 
            }

        let specificClinicianById = do
            { string "/clinicians/"
            ; clinicianId <- parseId
            ; optional "/"
            ; endOfInput
            ; pure ShowClinicianAction { clinicianId = Just clinicianId, clinicianName = Nothing }
            }

        allClinicians <|> specificClinicianByName <|> specificClinicianById 


