module Web.View.Counselors.Index where
import Web.View.Prelude

data IndexView = IndexView { counselors :: [Counselor]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewCounselorAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Counselor</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach counselors renderCounselor}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Counselors" CounselorsAction
                ]

renderCounselor :: Counselor -> Html
renderCounselor counselor = [hsx|
    <tr>
        <td>{counselor}</td>
        <td><a href={ShowCounselorAction counselor.id}>Show</a></td>
        <td><a href={EditCounselorAction counselor.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteCounselorAction counselor.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]