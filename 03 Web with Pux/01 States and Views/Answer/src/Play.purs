module App.Play where

import Prelude hiding (div)
import Pux.Html (text, div, Html)
import Pux.Html.Attributes (className)

----- Exercise -----

-- TODO: Change the type to have a single "score" Int.
type State = { score :: Int }

-- TODO: Have the initial state match the State.
init :: State
init = { score: 0 }

data Action = Todo

update :: Action -> State -> State
update action state = state

view :: State -> Html Action
view state =
  -- TODO: Have the text print out the score, using "show"
  --       to turn the Int into a String.
  div [ className "game" ] [ text ("An integer: " <> show state.score) ]
