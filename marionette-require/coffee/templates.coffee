define (require) ->
  "use strict"
  todoItemView: require "tpl!templates/todoItemView.tmpl"
  todosCompositeView: require "tpl!templates/todoListCompositeView.tmpl"
  footer: require "tpl!templates/footer.tmpl"
  header: require "tpl!templates/header.tmpl"