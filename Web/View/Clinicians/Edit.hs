module Web.View.Clinicians.Edit where
import Web.View.Prelude

data EditView = EditView { clinician :: Clinician }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Clinician</h1>
        {renderForm clinician}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Clinicians" CliniciansAction
                , breadcrumbText "Edit Clinician"
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