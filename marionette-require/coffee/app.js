// Generated by CoffeeScript 1.6.3
(function() {
  define(["marionette", "collections/TodoList", "views/HeaderView", "views/TodoListCompositeView", "views/FooterView"], function(Marionette, TodoList, HeaderView, TodoListCompositeView, FooterView) {
    var app, footer, header, main, todoList, viewOptions;
    app = new Marionette.Application();
    todoList = new TodoList();
    viewOptions = {
      collection: todoList
    };
    header = new HeaderView(viewOptions);
    main = new TodoListCompositeView(viewOptions);
    footer = new FooterView(viewOptions);
    app.addRegions({
      header: "#header",
      main: "#main",
      footer: "#footer"
    });
    app.addInitializer(function() {
      app.header.show(header);
      app.main.show(main);
      app.footer.show(footer);
      return todoList.fetch();
    });
    app.listenTo(todoList, "all", function() {
      app.main.$el.toggle(todoList.length > 0);
      return app.footer.$el.toggle(todoList.length > 0);
    });
    app.vent.on("todoList:filter", function(filter) {
      footer.updateFilterSelection(filter);
      return document.getElementById("todoapp").className = "filter-" + (filter === '' ? "all" : filter);
    });
    app.vent.on("todoList:clear:completed", function() {
      return todoList.getCompleted().forEach(function(todo) {
        return todo.destroy();
      });
    });
    return window.app = app;
  });

}).call(this);