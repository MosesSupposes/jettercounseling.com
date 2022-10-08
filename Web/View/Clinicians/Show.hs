module Web.View.Clinicians.Show where
import Web.View.Prelude

data ShowView = ShowView { clinician :: Clinician }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Clinician</h1>
        <p>{clinician}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Clinicians" CliniciansAction
                            , breadcrumbText "Show Clinician"
                            ]