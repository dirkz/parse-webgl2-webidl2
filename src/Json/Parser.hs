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
    { ttype :: !Text
    , value :: ![Value]
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Rhs)

data IdlType = IdlType
    { ttype    :: !Text
    , generic  :: !Text
    , nullable :: Bool
    , union    :: Bool
    , idlType  :: !Text
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''IdlType)

data ExtAttr = ExtAttr
    { ttype :: !Text
    , name  :: !Text
    , rhs   :: [Rhs]
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''ExtAttr)

data Default = Default
    { ttype :: !Text
    , value :: ![Value]
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Default)

data Argument = Argument
    { ttype    :: !Text
    , name     :: !Text
    , rhs      :: [Rhs]
    , extAttrs :: [ExtAttr]
    , idlType  :: IdlType
    , optional :: Bool
    , variadic :: Bool
    , ddefault :: Maybe Default
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Argument)
