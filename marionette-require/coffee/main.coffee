require.config
  paths:
    underscore: "../bower_components/underscore/underscore"
    backbone: '../bower_components/backbone/backbone'
    marionette: '../bower_components/backbone.marionette/lib/backbone.marionette'
    jquery: '../bower_components/jquery/jquery'
    localStorage: '../bower_components/backbone.localStorage/backbone.localStorage'
    tpl: 'lib/tpl'

  shim:
    underscore:
      exports: "_"

    backbone:
      exports: "Backbone"
      deps: ["jquery", "underscore"]

    marionette:
      exports: "Backbone.Marionette"
      deps: ["backbone"]

require [
  "app"
  "backbone"
  "roters/index"
  "controllers/index"
], (app, Backbone, Router, Controller) ->
  "use strict"

  app.start()

  new Router
    controller: Controller

  Backbone.history.start()


