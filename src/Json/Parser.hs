{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Json.Parser where

import           Data.Aeson.TH
import           Data.Text                      ( Text )

import           Json.Options

newtype Value = Value
    { value :: Text }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions ''Value)

data Rhs = Rhs
    { ttype :: Text
    , value :: [Value]
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = rhsFieldLabelModifier} ''Rhs)
