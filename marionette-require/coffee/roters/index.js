// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["marionette"], function(Marionette) {
    "use strict";
    var TodoRouter, _ref;
    return TodoRouter = (function(_super) {
      __extends(TodoRouter, _super);

      function TodoRouter() {
        _ref = TodoRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      TodoRouter.prototype.appRoutes = {
        "*filter": "setFilter"
      };

      return TodoRouter;

    })(Marionette.AppRouter);
  });

}).call(this);
