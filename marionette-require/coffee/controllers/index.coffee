define [
  "app"
], (app) ->
  "use strict"

  setFilter: (param) ->
    app.vent.trigger("todoList:filter", param and param.trim() or "")