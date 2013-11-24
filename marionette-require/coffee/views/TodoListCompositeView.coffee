define [
  "marionette"
  "templates"
  "views/TodoItemView"
], (Marionette, templates, ItemView) ->
  "use strict"

  class TodoListCompositeView extends Marionette.CompositeView
    template: templates.todosCompositeView

    itemView: ItemView

    itemViewContainer: "#todo-list"

    ui:
      toggle: "#toggle-all"

    events:
      "click #toggle-all": "onToggleAllClick"

    initialize: ->
      @listenTo @collection, "all", @updateToggleCheckbox

    onRender: ->
      @updateToggleCheckbox()

    updateToggleCheckbox: ->
      allCompleted = @collection.reduce (lastModel, thisModel) ->
        lastModel and thisModel.get "completed"
      , true

      @ui.toggle.prop "checked", allCompleted

    onToggleAllClick: (event) ->
      isChecked = event.currentTarget.checked

      @collection.each (todo) ->
        todo.save
          completed: isChecked

