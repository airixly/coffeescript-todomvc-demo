TodoMVC.module "Todos", (Todos, App, Backbone, Marionette, $, _) ->
  localStorageKey = "todos-backbone-marionettejs"

  class Todos.Todo extends Backbone.Model
    localStorage: new Backbone.LocalStorage localStorageKey
    defaults:
      title: ""
      completed: false
      created: 0

    initialize: ->
      @set "created", Date.now() if @isNew()

    toggle: ->
      @set "completed", not @isCompleted()

    isCompleted: ->
      @get "completed"

  class Todos.TodoList extends Backbone.Collection
    model: Todos.Todo
    localStorage: new Backbone.LocalStorage localStorageKey

    getCompleted: ->
      @filter @._isCompleted

    getActive: ->
      @reject @._isCompleted

    comparator: (todo) ->
      todo.get "created"

    _isCompleted: (todo) ->
      todo.isCompleted()