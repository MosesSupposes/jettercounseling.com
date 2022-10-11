module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)


data CounselorsController
    = CounselorsAction -- TODO: Remove
    | NewCounselorAction -- TODO: Remove 
    | ShowCounselorAction { counselorId :: !(Id Counselor) } -- TODO: Remove
    | CreateCounselorAction
    | EditCounselorAction { counselorId :: !(Id Counselor) } -- TODO: Remove
    | UpdateCounselorAction { counselorId :: !(Id Counselor) }
    | DeleteCounselorAction { counselorId :: !(Id Counselor) }
    deriving (Eq, Show, Data)
