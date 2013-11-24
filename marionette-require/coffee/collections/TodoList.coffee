define [
  "backbone"
  "models/Todo"
  "localStorage"
], (Backbone, Todo) ->
  "use strict"

  isCompleted = (todo) ->
    todo.get("completed")

  Backbone.Collection.extend
    model: Todo

    localStorage: new Backbone.LocalStorage "todos-backbone"

    getCompleted: ->
      this.filter isCompleted

    getActive: ->
      this.reject isCompleted

    comparator: (todo) ->
      todo.get("created")

