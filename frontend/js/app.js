/**
 * This class holds the business logic to bootstrap the application.
 */
var App = function () {};

/**
 * This method dispatches the router and initializes third party libraries.
 */
App.prototype.start = function () {
  var targets = new AppRouteTargets(),
      routes  = new Routes();

  routes.dispatch(targets);
  smoothScroll.init();
}


