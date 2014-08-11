/**
 * This object handles the routing via Aviator.
 */
var Routes = function() {};

/**
 * Set Aviator's routes and navigate to the current path.
 */
Routes.prototype.dispatch = function(targets) {
  Aviator.setRoutes({
    target: targets,
    '/': 'home',
    '/about': 'about',
    '/legal': 'legal',
    '/contact': 'contact',
    '/results': 'results',
  });

  Aviator.dispatch();
};
