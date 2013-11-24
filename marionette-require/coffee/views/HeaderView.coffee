define [
  "marionette"
  "templates"
], (Marionette, templates) ->
  class HeaderView extends Marionette.ItemView
    template: templates.header

    ui:
      input: "#new-todo"

    events:
      "keypress #new-todo": "onInpuKeypress"

    onInpuKeypress: (event) ->
      ENTER_KEY = 13
      todoText = @ui.input.val().trim()

      if event.which is ENTER_KEY and todoText
        @collection.create
          title: todoText
        @ui.input.val ""