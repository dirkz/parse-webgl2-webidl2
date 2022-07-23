{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Aeson
import qualified Data.ByteString.Lazy          as B
import Text.Pretty.Simple (pPrint)

import           Json.Parser

main :: IO ()
main = do
    jsonBS <- B.readFile "data/webgl2.idl.json"
    let decls = eitherDecode jsonBS :: Either String [Declaration]
    pPrint decls
