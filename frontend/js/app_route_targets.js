/**
 * This class holds the logic for mounting/unmounting React components based on
 * the URL.
 */
var AppRouteTargets = function() {};

AppRouteTargets.prototype = {
  /**
   * Go to the home page.
   */
  home: function(request, options) {
    this.mount('Home', Views.Home());
  },

  /**
   * Go to the about page.
   */
  about: function(request, options) {
    this.mount('About', Views.About());
  },

  /**
   * Go to the contact page.
   */
  contact: function(request, options) {
    this.mount('Contact', Views.Contact());
  },

  /**
   * Go to the legal page.
   */
  legal: function(request, options) {
    this.mount('Legal', Views.Legal());
  },

  /**
   * Go to the results page.
   */
  results: function(request, options) {
    this.mount('Home', Views.Results());
  },

  /**
   * Mount the given component, and set the navbar active at the specified
   * tab.
   */
  mount: function(active, component) {
    React.unmountComponentAtNode(contentNode);
    React.renderComponent(component, contentNode);

    React.unmountComponentAtNode(navNode);
    React.renderComponent(Views.Nav({ active: active }), navNode);
  },
};
