{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Json.Manual where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Aeson.Types
import           Data.Text                      ( Text )

import           Json.Options

data IdlType = IdlType
    { ttype    :: Maybe Text
    , generic  :: !Text
    , nullable :: Bool
    , union    :: Bool
    , idlType  :: IdlTypeInner
    }
    deriving (Show, Eq, Ord)

data IdlTypeInner = IdlTypeObject IdlType | IdlTypeArray [IdlType] | IdlTypeText Text
    deriving (Show, Eq, Ord)

instance FromJSON IdlTypeInner where
    parseJSON (Object v) =
        IdlTypeObject
            <$> (   IdlType
                <$> v
                .:  "type"
                <*> v
                .:  "generic"
                <*> v
                .:  "nullable"
                <*> v
                .:  "union"
                <*> v
                .:  "idlType"
                )

    parseJSON (   String s) = return $ IdlTypeText s

    parseJSON ar@(Array  _) = IdlTypeArray <$> parseJSON ar

    parseJSON invalid       = prependFailure
        "nested idlType (idlType.idlType), "
        (typeMismatch "not Object, String or Array" invalid)

instance ToJSON IdlTypeInner where
    toJSON (IdlTypeText   s  ) = String s
    toJSON (IdlTypeArray  ar ) = toJSON ar
    toJSON (IdlTypeObject obj) = toJSON obj

$(deriveJSON defaultOptions{fieldLabelModifier = defaultFieldLabelModifier} ''IdlType)
