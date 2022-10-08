module Web.View.Clinicians.Index where
import Web.View.Prelude

data IndexView = IndexView { clinicians :: [Clinician]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewClinicianAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Clinician</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach clinicians renderClinician}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Clinicians" CliniciansAction
                ]

renderClinician :: Clinician -> Html
renderClinician clinician = [hsx|
    <tr>
        <td>{clinician}</td>
        <td><a href={ShowClinicianAction clinician.id}>Show</a></td>
        <td><a href={EditClinicianAction clinician.id} class="text-muted">Edit</a></td>
        <td><a href={DeleteClinicianAction clinician.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]