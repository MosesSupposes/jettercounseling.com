module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

-- Generator Marker
instance AutoRoute StaticController

instance HasPath CliniciansController where
    pathTo CliniciansAction = "/clinicians"
    -- pathTo ShowClinicianAction = ""


