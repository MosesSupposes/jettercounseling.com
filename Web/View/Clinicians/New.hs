module Web.View.Clinicians.New where
import Web.View.Prelude

data NewView = NewView { clinician :: Clinician }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Clinician</h1>
        {renderForm clinician}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Clinicians" CliniciansAction
                , breadcrumbText "New Clinician"
                ]

renderForm :: Clinician -> Html
renderForm clinician = formFor clinician [hsx|
    {(textField #fullName)}
    {(textField #email)}
    {(textField #phoneNumber)}
    {(textField #profilePic)}
    {(textField #gender)}
    {(textField #bio)}
    {(textField #raceAndEthnicity)}
    {submitButton}

|]