this.TodoMVC = TodoMVC = new Backbone.Marionette.Application()

TodoMVC.addRegions
  header: "#header"
  main: "#main"
  footer: "#footer"

TodoMVC.on "initialize:after", =>
  Backbone.history.start()