define [
  'marionette'
  'templates'
  'views/ActiveCountView'
  'views/CompletedCountView'
], (Marionette, templates, ActiveCountView, CompletedCountView) ->
  class FooterView extends Marionette.Layout
    template: templates.footer

    regions:
      activeCount: "#todo-count"
      completedCount: "#clear-completed"

    ui:
      filters: "#filters a"

    events:
      "click #clear-completed": "onClearClick"

    onRender: ->
      @activeCount.show new ActiveCountView
        collection: @collection

      @completedCount.show new CompletedCountView
        collection: @collection

    updateFilterSelection: (filter) ->
      @ui.filters
      .removeClass("selected")
      .filter("[href='#/#{filter}']")
      .addClass "selected"

    onClearClick: ->
      window.app.vent.trigger "todoList:clear:completed"
