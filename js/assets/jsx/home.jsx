/** @jsx React.DOM */

var Views = Views || {};

Views.Home = React.createClass({
  render: function() {
    return (
      <div className="container-fluid">
        <div className="jumbotron text-center">
          <h1>Drink, don't think.</h1>

          <p className="lead">
            Use Magic Eight Bar to find bars similiar to ones you frequent.
          </p>
        </div>

        {Views.Search()}
      </div>
    );
  }
});
