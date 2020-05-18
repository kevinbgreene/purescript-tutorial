'use strict';

exports.clickEvent = 'click';

exports.inputEvent = 'input';

exports.addEvent = function (eventType) {
  return function (eventHandler) {
    return function () {
      return document.addEventListener(eventType, (evt) => {
        return eventHandler(evt)();
      })
    }
  }
}
