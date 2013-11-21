TodoMVC.module "TodoList.Views", (Views, App, Backbone, Marionette, $, _) ->
  class Views.ItemView extends Marionette.ItemView
    tagName: "li"
    template: "#template-todoItemView"
    ui:
      edit: ".edit"
    events:
      "click .destroy": "destroy"
      "dblclick label": "onEditClick"
      "keypress .edit": "onEditKeypress"
      "blur .edit": "onEditBlur"
      "click .toggle": "toggle"

    initialize: ->
      @listenTo @model, "change", @render

    onRender: ->
      @$el.removeClass "active completed"
      if @model.get "completed"
        @$el.addClass("completed")
      else
        @$el.addClass("active")

    destroy: ->
      @model.destroy()

    toggle: ->
      @model.toggle().save()

    onEditClick: ->
      @$el.addClass("editing")
      @ui.edit.focus()

    updateTodo: ->
      todoText = @ui.edit.val()
      @destroy() if todoText is ""
      @setTodoText todoText
      @completeEdit()

    onEditBlur: ->
      @updateTodo()

    onEditKeypress: (e) ->
      ENTER_KEY = 13
      @updateTodo() if e.which is ENTER_KEY

    setTodoText: (todoText) ->
      return if todoText.trim() is ""
      @model.set("title", todoText).save()

    completeEdit: ->
      @$el.removeClass "editing"

  class Views.ListView extends Backbone.Marionette.CompositeView
    template: "#template-todoListCompositeView"
    itemView: Views.ItemView
    itemViewContainer: "#todo-list"
    ui:
      toggle: "#toggle-all"

    events:
      "click #toogle-all": "onToggleAllClick"

    initialize: ->
      @listenTo @collection, "all", @update
      onRender: ->
        @update()

      update: ->
        reduceCompleted = (left, right) ->
          left and right.get "completed"

        allCompleted = @collection.reduce reduceCompleted, true
        @ui.toggle.prop "checked", allCompleted
        @$el.parent().toggle !!@collection.length

      onToggleAllClick: (e) ->
        isChecked = e.currentTarget.checked
        @collection.each (todo)->
          todo.save
            "completed": isChecked

  App.vent.on "todoList:filter", (filter) =>
    filter = filter or "all"
    $("#todoapp").attr "class", "filter-#{filter}"