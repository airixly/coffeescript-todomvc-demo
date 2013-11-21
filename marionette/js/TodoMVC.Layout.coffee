TodoMVC.module "Layout", (Layout, App, Backbone, Marionette, $, _) ->
  class Layout.Header extends Backbone.Marionette.ItemView
    template: "#template-header"

    ui:
      input: "#new-todo"

    events:
      "keypress #new-todo": "onInputKeypress"
      "blur #new-todo": "onTodoBlur"

    onTodoBlur: ->
      todoText = @ui.input.val().trim()
      @createTodo todoText

    onInputKeypress: (e) ->
      ENTER_KEY = 13
      todoText = @ui.input.val().trim()

      @createTodo todoText if e.which is ENTER_KEY and todoText

    completeAdd: ->
      @ui.input.val("")

    createTodo: (todoText) ->
      return if todoText.trim() is ""

      @collection.create
        title: todoText

      @completeAdd()

  class Layout.Footer extends Backbone.Marionette.Layout
    template: "#template-footer"
    ui:
      todoCount: "#todo-count .count"
      todoCountLable: "#todo-count .lable"
      clearCount: "#clear-completed .count"
      filters: "#filters a"

    events:
      "click #clear-completed": "onClearClick"

    initialize: ->
      @listenTo App.vent, "todoList:filter", @updateFilterSelection
      @listenTo @collection, "all", @updateCount

    onRender: ->
      @updateCount

    updateCount: ->
      activeCount = @collection.getActive().length
      completedCount = @collection.getCompleted().length
      @ui.todoCount.html activeCount
      @ui.todoCountLable.html if activeCount is 1 then "item" else "items"
      @ui.clearCount.html if completedCount is 0 then "" else "(#{completedCount})"

    updateFilterSelection: (filter) ->
      @ui.filters.removeClass("selected").filter("[href='##{filter}']").addClass("selected")

    onClearClick: ->
      completed = @collection.getCompleted()
      completed.forEach (todo) ->
        todo.destroy()
