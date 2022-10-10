-- TODO: keep this file in sync with /static/404.html. These two pages serve the same purpose. 
-- This file was created for intentional 404 redirects, where the other file (404.html) was created as a fallback to be used by the IHP framework.
module Web.View.Static.NotFound where

import Web.View.Prelude

data NotFoundView = NotFoundView

instance View NotFoundView where
  html NotFoundView =
    [hsx|
        <div class="not-found-404">
          <h1>Page Not Found</h1>
        </div>
    |]
