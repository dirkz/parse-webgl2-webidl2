module Json.Options
    ( defaultFieldLabelModifier
    ) where

defaultFieldLabelModifier :: String -> String
defaultFieldLabelModifier "ttype"    = "type"
defaultFieldLabelModifier "ddefault" = "default"
defaultFieldLabelModifier name       = name
