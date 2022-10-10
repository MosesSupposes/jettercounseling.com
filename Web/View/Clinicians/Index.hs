module Web.View.Clinicians.Index where
import Web.View.Prelude

data IndexView = IndexView { clinicians :: [Clinician]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}
        <div>{forEach clinicians renderClinician}</div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Clinicians" CliniciansAction
                ]

renderClinician :: Clinician -> Html
renderClinician clinician = [hsx|
    <div>
        <div>{clinician}</div>
        <div><a href={ShowClinicianAction (Just clinician.id) (Just clinician.fullName)}>Show</a></div>
    </div>
|]
