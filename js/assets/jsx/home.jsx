/** @jsx React.DOM */

var Views = Views || {};

Views.Home = React.createClass({
  render: function() {
    return (
      <div className="container-fixed">
        <div className="jumbotron text-center fix-margin">
          <h1 className="push-down">Drink, don't think.</h1>
          <p className="lead">
            Use Magic Eight Bar to find bars similiar to ones you frequent.
          </p>
        </div>

        {Views.Search()}
      </div>
    );
  }
});
