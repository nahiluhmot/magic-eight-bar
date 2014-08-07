/** @jsx React.DOM */

var Views = Views || {};

Views.Results = React.createClass({
  getInitialState: function() {
    return { bar: {} };
  },

  componentWillMount: function() {
    this.getNextPrediction();
  },

  getNextPrediction: function() {
    var component = this;

    Predictions.next({
      error: function() {
        console.log('Error getting next prediction');
      },
      success: function(bar) {
        component.setState({ bar: bar });
      }
    });
  },

  render: function() {
    return (
      <div className="container-fluid fix-margin top-level">
        <div className="row">
          <h1>Prediction</h1>
        </div>

        <div className="row">
          <p className="lead">You should go to: {this.state.bar.name}!</p>
        </div>

        <div className="row">
          <div className="col-lg-6">
          </div>

          <div className="col-lg-6">
          </div>
        </div>

      </div>
    );
  }
});
