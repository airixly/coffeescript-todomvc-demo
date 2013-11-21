TodoMVC.module "TodoList", (TodoList, App, Backbone, Marionette, $, _) ->
  TodoList.Router = Marionette.AppRouter.extend
    appRoutes:
      "*filter": "filterItems"

  class TodoList.Controller extends Backbone.Wreqr.EventAggregator
    constructor: () ->
      @todoList = new App.Todos.TodoList()

    start: ->
      @showHeader @todoList
      @showFooter @todoList
      @showTodoList @todoList

      @listenTo @todoList, "reset add remove", @toggleFooter
      @todoList.fetch()

    showHeader: (todoList) ->
      header = new App.Layout.Header collection: todoList
      App.header.show header

    showFooter: (todoList) ->
      footer = new App.Layout.Footer collection: todoList
      App.footer.show footer

    showTodoList: (todoList) ->
      App.main.show new TodoList.Views.ListView collection: todoList

    toggleFooter: ->
      App.footer.$el.toggle @todoList.length isnt 0

    filterItems: (filter) ->
      App.vent.trigger "todoList:filter", filter and filter.trim() or ""

  TodoList.addInitializer ->
    controller = new TodoList.Controller()
    new TodoList.Router controller: controller
    controller.start()