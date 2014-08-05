/** @jsx React.DOM */

var Views = Views || {};

Views.Home = React.createClass({
  render: function() {
    return (
      <div className="container-fixed">
        <div className="jumbotron text-center fix-margin">
          <h1 className="push-down">Drink, don't think.</h1>
          <p className="lead">
            Use Magic Eight Bar to explore new bars in Boston.
          </p>
        </div>

        {Views.Warning()}
        {Views.Search()}
      </div>
    );
  }
});
