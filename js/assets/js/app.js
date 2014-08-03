var App = function () {};

App.prototype.start = function () {
  var targets = new AppRouteTargets(),
      routes  = new Routes();

  routes.dispatch(targets);
}


