{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Json.Parser where

import           Data.Aeson.TH
import           Data.Text                      ( Text )

import           Json.Options
import Json.Manual

data Value = Value
    { ttype :: Maybe Text
    , value :: !Text
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Value)

data Rhs = Rhs
    { ttype :: !Text
    , value :: ![Value]
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Rhs)

data ExtAttr = ExtAttr
    { ttype :: !Text
    , name  :: !Text
    , rhs   :: Maybe Rhs
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

data Member = Member
    { ttype    :: !Text
    , name     :: !Text
    , idlType  :: IdlType
    , extAttrs :: [ExtAttr]
    , value    :: Maybe Value
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Member)

data Declaration = Declaration
    { ttype       :: !Text
    , name        :: Maybe Text
    , idlType     :: Maybe IdlType
    , rhs         :: Maybe [Rhs]
    , extAttrs    :: [ExtAttr]
    , partial     :: Maybe Bool
    , inheritance :: Maybe Text
    , members     :: Maybe [Member]
    }
    deriving (Show, Eq, Ord)

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''Declaration)
