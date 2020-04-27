module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)

import Web.HTML (window)
import Web.HTML.Window (document)
import Web.HTML.HTMLDocument (toEventTarget, toParentNode, HTMLDocument)
import Web.HTML.HTMLInputElement (fromEventTarget, value, HTMLInputElement)

import Web.DOM.Element (Element, toNode)
import Web.DOM.Node (setTextContent)
import Web.DOM.ParentNode (querySelector, QuerySelector(QuerySelector))

import Web.Event.Event (Event, EventType(..), target)
import Web.Event.EventTarget (EventTarget, eventListener, addEventListener)

rootSelector :: QuerySelector
rootSelector = QuerySelector ("#root")

inputEvent :: EventType
inputEvent = EventType ("input")

selectFromDocument :: HTMLDocument -> Effect (Maybe Element)
selectFromDocument doc = querySelector rootSelector (toParentNode doc)

updateText :: String -> Maybe Element -> Effect Unit
updateText str (Just el) = setTextContent str (toNode el)
updateText _ _ = pure unit

inputValue :: Maybe HTMLInputElement -> Effect String
inputValue (Just el) = value el
inputValue _ = pure ""

targetValue :: Maybe EventTarget -> Effect String
targetValue (Just et) = inputValue (fromEventTarget et)
targetValue _ = pure ""

eventValue :: Event -> Effect String
eventValue evt = targetValue (target evt)

inputEventHandler :: Maybe Element -> Event -> Effect Unit
inputEventHandler el evt = do 
  str <- eventValue evt
  updateText str el

main :: Effect Unit
main = do
  w <- window
  d <- document w
  el <- selectFromDocument d
  eh <- eventListener (inputEventHandler el)
  addEventListener inputEvent eh true (toEventTarget d)
