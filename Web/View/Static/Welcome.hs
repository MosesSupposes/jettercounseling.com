module Web.View.Static.Welcome where

import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
  html WelcomeView =
    [hsx|
          <main class="elm"></main> 
|]
