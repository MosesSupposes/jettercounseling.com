module Web.View.Counselors.New where
import Web.View.Prelude

data NewView = NewView { counselor :: Counselor }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Counselor</h1>
        {renderForm counselor}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Counselors" CounselorsAction
                , breadcrumbText "New Counselor"
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