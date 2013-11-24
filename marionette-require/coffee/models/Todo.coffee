define [
  "backbone"
  "localStorage"
], (Backbone) ->
  "use strict"

  class Todo extends Backbone.Model
    localStorage: new Backbone.LocalStorage "todos-backbone"

    defaults:
      title: ""
      completed: false
      created: 0

    initialize: ->
      if @isNew() then @set "created", Date.now()

    toggle: ->
      @set "completed", not @get "completed"

