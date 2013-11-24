define [
  "marionette"
  "jquery"
], (Marionette, $) ->
  class ActiveCountView extends Marionette.View
    initialize: ->
      @listenTo @collection, "all", @render

    render: ->
      @$el = $ "#todo-count"

      itemsLeft = @collection.getActive().length
      itemsWord = if itemsLeft < 1 or itemsLeft > 1 then "items" else "item"

      @$el.html "<strong>#{itemsLeft}</strong>#{itemsWord} left"