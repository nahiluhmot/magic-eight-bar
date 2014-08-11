/** @jsx React.DOM */

var Views = Views || {};

/**
 * This component handles logic for the '/' route.
 */
Views.Home = React.createClass({
  /**
   * Render the home page. This page mounts Views.Warning to ensure that a user
   * is logged in and Views.Search to provide search functionality.
   */
  render: function() {
    return (
      <div className="container-fixed">
        <div className="jumbotron text-center fix-margin">
          <h1 className="push-down">Drink, don't think.</h1>
          <p className="lead">
            Use Magic 8 Bar to explore new bars in Boston.
          </p>
        </div>

        {Views.Warning()}
        {Views.Search()}
      </div>
    );
  }
});
