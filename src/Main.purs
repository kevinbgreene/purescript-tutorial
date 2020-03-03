module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)

import Web.HTML (window)
import Web.HTML.Window (document)
import Web.HTML.HTMLDocument (toParentNode, HTMLDocument)

import Web.DOM.Element (Element, toNode)
import Web.DOM.Node (textContent)
import Web.DOM.ParentNode (querySelector, QuerySelector(QuerySelector))

rootSelector :: QuerySelector
rootSelector = QuerySelector ("#root")

maybeText :: Maybe Element -> Effect String
maybeText (Just el) = textContent  (toNode el)
maybeText _ = pure ""

selectFromDocument :: HTMLDocument -> Effect (Maybe Element)
selectFromDocument doc = querySelector rootSelector (toParentNode doc)

main :: Effect Unit
main = window >>= document >>= selectFromDocument >>= maybeText >>= log
