define [
  "marionette"
  "jquery"
],(Marionette,$) ->
  class CompletedCountView extends Marionette.View
    initialize: ->
      @listenTo @collection,"all",@render

    render: ->
      @$el = $ "#clear-completed"

      completedTodos = @collection.getCompleted()

      @$el
        .toggle(completedTodos.length)
        .html "Clear completed(#{completedTodos.length})"