var Routes = function() {};

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
