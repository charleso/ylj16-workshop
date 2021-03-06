module App.Play where

import Prelude hiding (div)
import Pux (EffModel, noEffects)
import Pux.Html (button, text, div, Html)
import Pux.Html.Attributes (className)
import Pux.Html.Events (onClick)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Random (RANDOM, randomInt)

type State = { score :: Int }

init :: State
init = { score: 0 }

----- Exercise -----
data Action = ResetGame
            | StartShuffle
            | ResolveShuffle Int

-- The parent component (App.Layout) was altered to expect this newly-effectful
-- update function.
update :: forall eff. Action -> State -> EffModel State Action (random :: RANDOM | eff)
update ResetGame    state = noEffects init

-- TODO: Create an effect that generates a random integer, and returns a
--       ResolveShuffle with the number.
--       Use liftEff in front of any Eff effects you want to use.
--       Note: You'll need to update the `eff` type of this function.
update StartShuffle state =
  let resolveRandom = do
        n <- liftEff (randomInt 0 999)
        pure (ResolveShuffle n)
   in { state: state  -- Pass state through as-is.
      , effects: [ resolveRandom ]
      }

-- TODO: Add an `update` case to deal with receiving the random integer, and
--       updating the score to that value.
update (ResolveShuffle n) state =
  noEffects (state { score = n })


view :: State -> Html Action
view state =
  div [ className "game" ]
    [ button [ onClick (\e -> StartShuffle) ] [ text (show state.score) ]
    , button [ onClick (\e -> ResetGame) ] [ text "Reset" ]
    ]
