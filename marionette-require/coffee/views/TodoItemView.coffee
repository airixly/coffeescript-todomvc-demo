define [
  "marionette"
  "templates"
], (Marionette, templates) ->
  "use strict"
  ENTER_KEY = 13
  ESCAPE_KEY = 27

  class TodoItemView extends Marionette.CompositeView
    tagName: "li"

    template: templates.todoItemView

    value: ""

    ui:
      edit: ".edit"

    events:
      "click .toggle": "toggle"
      "click .destroy": "destroy"
      "dblclick label": "onEditDblclick"
      "keypress .edit": "onEditKeypress"
      "blur .edit": "onEditBlur"

    initialize: ->
      @value = @model.get "title"

      @listenTo @model, "change", @render

    onRender: ->
      @$el
      .removeClass("active completed")
      .addClass if @model.get "completed" then "completed" else "active"

    destroy: ->
      @model.destroy()

    toggle: ->
      @model.toggle().save()

    toggleEditingMode: ->
      @$el.toggleClass("editing")

    onEditDblclick: ->
      @toggleEditingMode()

      @ui.edit.focus().val @value

    onEditKeypress: (event) ->
      if event.which is ENTER_KEY then @ui.edit.trigger "blur"

      if event.which is ESCAPE_KEY then @toggleEditingMode()

    onEditBlur: (event) ->
      @value = event.target.value.trim()

      if @value then @model
      .set("title",@value)
      .save()
      else @destroy()

      @toggleEditingMode()