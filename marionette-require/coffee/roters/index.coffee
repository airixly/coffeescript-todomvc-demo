define [
  "marionette"
], (Marionette) ->
  "use strict"
  class TodoRouter extends Marionette.AppRouter
    appRoutes:
      "*filter": "setFilter"