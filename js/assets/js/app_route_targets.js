var AppRouteTargets = function() {};

AppRouteTargets.prototype = {
  'home': function (request, options) {
    this.mount('Home', Views.Home());
  },

  'about': function (request, options) {
    this.mount('About', Views.About());
  },

  'contact': function (request, options) {
    this.mount('Contact', Views.Home());
  },

  'legal': function (request, options) {
    this.mount('Legal', Views.Home());
  },

  'mount': function (active, component) {
    React.unmountComponentAtNode(contentNode);
    React.renderComponent(component, contentNode);

    React.unmountComponentAtNode(navNode);
    React.renderComponent(Views.Nav({ active: active }), navNode);
  },
};
