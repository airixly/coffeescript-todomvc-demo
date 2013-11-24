define [
  "marionette"
  "collections/TodoList"
  "views/HeaderView"
  "views/TodoListCompositeView"
  "views/FooterView"
], (Marionette, TodoList, HeaderView, TodoListCompositeView, FooterView) ->
  app = new Marionette.Application()
  todoList = new TodoList()
  viewOptions =
    collection: todoList

  header = new HeaderView viewOptions
  main = new TodoListCompositeView viewOptions
  footer = new FooterView viewOptions

  app.addRegions
    header: "#header"
    main: "#main"
    footer: "#footer"

  app.addInitializer ->
    app.header.show header
    app.main.show main
    app.footer.show footer

    todoList.fetch()

  app.listenTo todoList, "all", ->
    app.main.$el.toggle todoList.length > 0
    app.footer.$el.toggle todoList.length > 0

  app.vent.on "todoList:filter", (filter) ->
    footer.updateFilterSelection(filter)
    document.getElementById("todoapp").className = "filter-" + if filter is '' then "all" else filter

  app.vent.on "todoList:clear:completed", ->
    todoList.getCompleted().forEach (todo)->
      todo.destroy()

  window.app = app;