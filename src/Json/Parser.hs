{-# LANGUAGE TemplateHaskell #-}

module Json.Parser where

import           Data.Aeson.TH
import           Data.Text                      ( Text )

newtype Value = Value
    { value :: Text }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions ''Value)
