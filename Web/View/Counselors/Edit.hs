module Web.View.Counselors.Edit where
import Web.View.Prelude

data EditView = EditView { counselor :: Counselor }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Counselor</h1>
        {renderForm counselor}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Counselors" CounselorsAction
                , breadcrumbText "Edit Counselor"
                ]

renderForm :: Counselor -> Html
renderForm counselor = formFor counselor [hsx|
    {(textField #fullName)}
    {(textField #email)}
    {(textField #phoneNumber)}
    {(textField #profilePic)}
    {(textField #gender)}
    {(textField #bio)}
    {(textField #raceAndEthnicity)}
    {submitButton}

|]