module Application.Helper.Controller where

import IHP.ControllerPrelude (Text)
import IHP.RouterPrelude ( omap)
import Prelude

-- Here you can add functions which are available in all your controllers

-- | Takes a path from the url and converts its dashes into spaces. 
fromSlugToFullWord ::  Text -> Text
fromSlugToFullWord =  omap (\char -> if char == '-' then ' ' else char) 
