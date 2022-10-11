module Web.View.Counselors.Show where
import Web.View.Prelude

data ShowView = ShowView { counselor :: Counselor }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Counselor</h1>
        <p>{counselor}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Counselors" CounselorsAction
                            , breadcrumbText "Show Counselor"
                            ]