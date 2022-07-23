module Json.Options
    ( rhsFieldLabelModifier
    ) where

rhsFieldLabelModifier :: String -> String
rhsFieldLabelModifier "ttype" = "type"
rhsFieldLabelModifier name    = name
